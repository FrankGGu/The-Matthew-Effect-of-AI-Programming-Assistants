(require data/heap)
(require data/hash)
(require data/hash-set)
(require data/red-black-tree) ; For available_movies_by_shop_id

(define movie-rental-system%
  (class object%
    (init-field n) ; Number of shops (not strictly used, but part of problem spec)
    (init-field movies) ; Initial list of (shopId movieId price)

    ; Comparison function for (price . movieId) pairs
    (define (price-movie-cmp a b)
      (let ((price-a (car a)) (movie-id-a (cdr a))
            (price-b (car b)) (movie-id-b (cdr b)))
        (or (< price-a price-b)
            (and (= price-a price-b) (< movie-id-a movie-id-b)))))

    ; Comparison function for (price . shopId) pairs
    (define (price-shop-cmp a b)
      (let ((price-a (car a)) (shop-id-a (cdr a))
            (price-b (car b)) (shop-id-b (cdr b)))
        (or (< price-a price-b)
            (and (= price-a price-b) (< shop-id-a shop-id-b)))))

    ; Comparison function for (price . movieId . shopId) triples for report
    (define (report-item-cmp a b)
      (let ((price-a (car a)) (movie-id-a (cadr a)) (shop-id-a (caddr a))
            (price-b (car b)) (movie-id-b (cadr b)) (shop-id-b (caddr b)))
        (or (< price-a price-b)
            (and (= price-a price-b) (< movie-id-a movie-id-b))
            (and (= price-a price-b) (= movie-id-a movie-id-b) (< shop-id-a shop-id-b)))))

    ; Data structures:

    ; 1. shop_movie_price_map: hash table ((shopId . movieId) -> price)
    ;    Stores the original price of each movie at each shop.
    (define shop_movie_price_map (make-hash))

    ; 2. available_movies_by_shop_id: hash table (shopId -> RBT (movieId -> price))
    ;    Each RBT stores available movies at that shop. Key: movieId, Value: price.
    ;    Used for efficient rent/drop operations at a specific shop.
    (define available_movies_by_shop_id (make-hash))

    ; 3. available_movies_by_movie_id: hash table (movieId -> heap of (price . shopId))
    ;    Each heap stores available shops for a given movie, sorted by price then shopId.
    ;    Used for efficient search operations. Uses lazy deletion with rented_movies_set.
    (define available_movies_by_movie_id (make-hash))

    ; 4. rented_movies_set: hash-set ((shopId . movieId))
    ;    Stores currently rented movies. Used for lazy deletion in search and report.
    (define rented_movies_set (make-hash-set))

    ; 5. report_heap: heap of (price . movieId . shopId)
    ;    Stores all currently rented movies, sorted by price, then movieId, then shopId.
    ;    Used for efficient report operations. Uses lazy deletion with rented_movies_set.
    (define report_heap (make-heap report-item-cmp))

    ; Constructor
    (define/public (initialize)
      (super initialize)
      (for-each
       (lambda (movie-info)
         (let ((shop-id (car movie-info))
               (movie-id (cadr movie-info))
               (price (caddr movie-info)))
           ; Store price for (shopId, movieId)
           (hash-set! shop_movie_price_map (cons shop-id movie-id) price)

           ; Add to available_movies_by_shop_id (RBT)
           (hash-update! available_movies_by_shop_id shop-id
                         (lambda (rbt) (rbt-add rbt movie-id price))
                         (lambda () (rbt-add (make-rbt-tree <) movie-id price)))

           ; Add to available_movies_by_movie_id (Heap)
           (hash-update! available_movies_by_movie_id movie-id
                         (lambda (h) (heap-add h (cons price shop-id)))
                         (lambda () (heap-add (make-heap price-shop-cmp) (cons price shop-id))))))
       movies))

    ; search(movie_id): list[int]
    (define/public (search movie_id)
      (define results '())
      (define current-movie-heap (hash-ref available_movies_by_movie_id movie_id (make-heap price-shop-cmp)))
      (define temp-heap (make-heap price-shop-cmp))

      (let loop ((count 0))
        (when (and (< count 5) (not (heap-empty? current-movie-heap)))
          (let* ((top-item (heap-extract-min! current-movie-heap))
                 (price (car top-item))
                 (shop-id (cdr top-item)))
            (heap-add! temp-heap top-item) ; Store for putting back

            (if (hash-has-key? rented_movies_set (cons shop-id movie_id))
                ; This movie is rented, skip it (lazy deletion)
                (loop count)
                ; This movie is available
                (begin
                  (set! results (cons shop-id results))
                  (loop (+ count 1)))))))

      ; Put back elements extracted from current-movie-heap
      (for-each (lambda (item) (heap-add! current-movie-heap item)) (heap-elements temp-heap))
      (reverse results))

    ; rent(shopId, movieId): void
    (define/public (rent shop-id movie-id)
      (let ((key (cons shop-id movie-id)))
        (let ((price (hash-ref shop_movie_price_map key #f)))
          (when (and price (not (hash-has-key? rented_movies_set key))) ; Ensure movie exists and not already rented
            (hash-add! rented_movies_set key) ; Mark as rented

            ; Remove from available_movies_by_shop_id (RBT)
            (hash-update! available_movies_by_shop_id shop-id
                          (lambda (rbt) (rbt-remove rbt movie-id))
                          (lambda () (error "rent: shop RBT not found for shop-id" shop-id)))

            ; Add to report_heap
            (heap-add! report_heap (list price movie-id shop-id))))))

    ; drop(shopId, movieId): void
    (define/public (drop shop-id movie-id)
      (let ((key (cons shop-id movie-id)))
        (let ((price (hash-ref shop_movie_price_map key #f)))
          (when (and price (hash-has-key? rented_movies_set key)) ; Ensure movie exists and is currently rented
            (hash-remove! rented_movies_set key) ; Mark as available

            ; Add back to available_movies_by_shop_id (RBT)
            (hash-update! available_movies_by_shop_id shop-id
                          (lambda (rbt) (rbt-add rbt movie-id price))
                          (lambda () (rbt-add (make-rbt-tree <) movie-id price)))

            ; Add back to available_movies_by_movie_id (Heap)
            (hash-update! available_movies_by_movie_id movie-id
                          (lambda (h) (heap-add h (cons price shop-id)))
                          (lambda () (heap-add (make-heap price-shop-cmp) (cons price shop-id))))))))

    ; report(): list[list[int]]
    (define/public (report)
      (define results '())
      (define temp-heap (make-heap report-item-cmp))

      (let loop ((count 0))
        (when (and (< count 5) (not (heap-empty? report_heap)))
          (let* ((top-item (heap-extract-min! report_heap))
                 (price (car top-item))
                 (movie-id (cadr top-item))
                 (shop-id (caddr top-item)))
            (heap-add! temp-heap top-item) ; Store for putting back

            (if (hash-has-key? rented_movies_set (cons shop-id movie-id))
                ; This movie is truly rented
                (begin
                  (set! results (cons (list shop-id movie-id) results))
                  (loop (+ count 1)))
                ; This movie was dropped, skip it (lazy deletion)
                (loop count)))))

      ; Put back elements extracted from report_heap
      (for-each (lambda (item) (heap-add! report_heap item)) (heap-elements temp-heap))
      (reverse results))))