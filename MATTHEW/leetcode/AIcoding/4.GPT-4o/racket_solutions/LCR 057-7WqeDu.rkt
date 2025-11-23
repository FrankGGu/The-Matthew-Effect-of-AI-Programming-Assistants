(define (containsNearbyAlmostDuplicate nums k t)
  (define (abs x) (if (< x 0) (- x) x))
  (define (check-bucket bucket)
    (for ([v (in-hash-table bucket)])
      (when (for/or ([u (in-hash-table bucket)]
                     #:when (not (= v u)))
            (<= (abs (- v u)) t))
        (return #t)))
    #f)

  (define bucket-size (if (zero? t) 1 (+ 1 t)))
  (define buckets (make-hash))

  (for* ([i (in-range (length nums))]
         [num (in-list nums)])
    (define bucket-key (if (< num 0) (/ num bucket-size) (/ num bucket-size)))
    (when (hash-ref buckets bucket-key #f)
      (when (<= (abs (- num (hash-ref buckets bucket-key))) t)
        (return #t)))
    (hash-set! buckets bucket-key num)
    (for ([j (in-range (- bucket-key 1) (+ bucket-key 2))])
      (when (hash-ref buckets j #f)
        (when (<= (abs (- num (hash-ref buckets j))) t)
          (return #t))))
    (when (hash-count buckets) 
      (hash-remove! buckets (if (< (length buckets) k) (+ bucket-key 1) (- bucket-key k))))))
  #f)

(containsNearbyAlmostDuplicate (list -1 0 1 1) 1 0)