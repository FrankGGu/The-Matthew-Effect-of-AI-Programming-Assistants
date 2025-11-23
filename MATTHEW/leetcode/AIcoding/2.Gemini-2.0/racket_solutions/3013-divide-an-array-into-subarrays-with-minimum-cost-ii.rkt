(define (minimum-cost-subarray
  arr
  k
  dist)
  (define n (vector-length arr))
  (define (calculate-cost l)
    (let loop ([i 0] [cost 0])
      (if (= i k)
          cost
          (loop (+ i 1) (+ cost (vector-ref arr i))))))

  (define (solve)
    (let* ([min-cost #f])
      (for ([i (in-range (- n k) (+ 1 dist))])
        (let* ([current-cost 0]
               [heap (make-heap < #:key (lambda (x) (vector-ref arr x)))]
               [selected-indices (make-vector k #f)]
               [unselected-indices (make-vector (- n k) #f)]
               [unselected-index 0])

          (for ([j (in-range n)])
            (if (and (>= j (- i dist)) (<= j i))
                (void)
                (heap-add! heap j)))

          (for ([j (in-range k)])
            (let ([min-index (heap-remove-min! heap)])
              (vector-set! selected-indices j min-index)
              (set! current-cost (+ current-cost (vector-ref arr min-index)))))

          (if (or (not min-cost) (< current-cost min-cost))
              (set! min-cost current-cost))))
      min-cost))

  (solve))