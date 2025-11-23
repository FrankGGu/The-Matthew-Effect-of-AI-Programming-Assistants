(require data/heap)

(struct movie (price shop) #:transparent)
(struct entry (price shop movie) #:transparent)

(define movie-rental-system%
  (class object%
    (super-new)
    (init-field [_n 0])
    (define movies (make-hash)) ; shop -> movie -> count
    (define rented (make-hash)) ; movie -> (heap of (list price shop))
    (define shop-rented (make-hash)) ; shop -> (set of movie)

    (define/public (search movie)
      (define candidates (heap))
      (hash-for-each
       movies
       (lambda (shop movie-counts)
         (hash-for-each
          movie-counts
          (lambda (m cnt)
            (when (and (equal? m movie) (> cnt 0))
              (heap-add! candidates (movie (movie-price m) shop)))))))
      (define result '())
      (let loop ()
        (when (and (not (heap-empty? candidates)) (< (length result) 5))
          (define m (heap-min candidates))
          (heap-remove! candidates)
          (set! result (cons (movie-shop m) result))
        (when (and (not (heap-empty? candidates)) (< (length result) 5))
          (loop)))
      (reverse result))

    (define/public (rent shop movie)
      (define movie-counts (hash-ref movies shop (hash)))
      (define cnt (hash-ref movie-counts movie 0))
      (when (<= cnt 0)
        (error "Movie not available"))
      (hash-set! movie-counts movie (sub1 cnt))
      (hash-set! movies shop movie-counts)
      (define rented-movies (hash-ref rented movie (heap (λ (a b) (< (first a) (first b))))))
      (heap-add! rented-movies (list (movie-price movie) shop))
      (hash-set! rented movie rented-movies)
      (define shop-movies (hash-ref shop-rented shop (set)))
      (set-add! shop-movies movie)
      (hash-set! shop-rented shop shop-movies))

    (define/public (drop shop movie)
      (define movie-counts (hash-ref movies shop (hash)))
      (hash-set! movie-counts movie (add1 (hash-ref movie-counts movie 0)))
      (hash-set! movies shop movie-counts)
      (define rented-movies (hash-ref rented movie (heap (λ (a b) (< (first a) (first b))))))
      (define to-remove (list (movie-price movie) shop))
      (define updated (heap-filter (λ (x) (not (equal? x to-remove))) rented-movies))
      (hash-set! rented movie updated)
      (define shop-movies (hash-ref shop-rented shop (set)))
      (set-remove! shop-movies movie)
      (hash-set! shop-rented shop shop-movies))

    (define/public (report)
      (define result '())
      (define candidates (heap (λ (a b) (< (entry-price a) (entry-price b)))))
      (hash-for-each
       rented
       (lambda (movie heap)
         (unless (heap-empty? heap)
           (define entry (heap-min heap))
           (heap-add! candidates (entry (first entry) (second entry) movie)))))
      (let loop ()
        (when (and (not (heap-empty? candidates)) (< (length result) 5))
          (define e (heap-min candidates))
          (heap-remove! candidates)
          (set! result (cons (list (entry-shop e) (entry-movie e)) result))
        (when (and (not (heap-empty? candidates)) (< (length result) 5))
          (loop)))
      (reverse result))))