(define (most-beautiful-item-for-each-query items queries)
  ;; 1. Sort items by price in ascending order.
  (define sorted-items
    (sort items (lambda (a b) (< (car a) (car b)))))

  ;; 2. Precompute maximum beauty for each price point.
  ;;    This creates a list of (price, max_beauty_up_to_this_price) pairs.
  ;;    The max_beauty_up_to_this_price is the maximum beauty among all items
  ;;    whose price is less than or equal to the current price.
  (define processed-items-list
    (let loop ((items sorted-items)
               (current-max-beauty 0)
               (acc '()))
      (if (empty? items)
          (reverse acc)
          (let* ((item (car items))
                 (price (car item))
                 (beauty (cadr item))
                 (new-max-beauty (max current-max-beauty beauty)))
            (loop (cdr items)
                  new-max-beauty
                  (cons (list price new-max-beauty) acc))))))

  ;; Convert the list of processed items to a vector for O(1) indexed access
  ;; during binary search.
  (define processed-items-vec (list->vector processed-items-list))
  (define vec-len (vector-length processed-items-vec))

  ;; 3. Process each query.
  ;;    For each query price, perform a binary search on processed-items-vec
  ;;    to find the maximum beauty.
  (map (lambda (query)
         (let ((query-price (car query)))
           ;; Binary search to find the largest index `k` such that
           ;; (car (vector-ref processed-items-vec k)) <= query-price.
           ;; The answer will be (cadr (vector-ref processed-items-vec k)).
           ;; If no such item exists, the answer is 0.
           (let find-max-beauty ((low 0)
                                 (high (sub1 vec-len))
                                 (best-idx -1)) ; Stores the index of the best item found so far
             (if (> low high)
                 (if (= best-idx -1)
                     0 ; No item found with price <= query-price
                     (cadr (vector-ref processed-items-vec best-idx)))
                 (let* ((mid (quotient (+ low high) 2))
                        (item-at-mid (vector-ref processed-items-vec mid))
                        (item-price (car item-at-mid)))
                   (if (<= item-price query-price)
                       ;; This item's price is valid. It's a potential answer.
                       ;; Try to find an item with an even higher price (further right).
                       (find-max-beauty (add1 mid) high mid)
                       ;; This item's price is too high. Search in the left half.
                       (find-max-beauty low (sub1 mid) best-idx)))))))
       queries))