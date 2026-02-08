(define (maximumTotalBeauty A)
  (define n (length A))
  (define (calculate-beauty A k)
    (let loop ((i 0) (total 0) (count 0))
      (if (>= i n)
          total
          (let ((current (A i)))
            (if (>= current k)
                (loop (+ i 1) (+ total k) (+ count 1))
                (loop (+ i 1) (+ total current) count))))))
  (define max-beauty (for/fold ([max 0]) ([k (in-range 1 (add1 (apply max A)))])
                         (max max (calculate-beauty A k))))
  max-beauty)

(maximumTotalBeauty (vector->list (vector 1 2 3))) ; Example input