(define (consecutive-numbers-sum n)
  (define (helper k)
    (if (> (* k (+ k 1)) (* 2 n))
        0
        (+ (if (= (remainder n k) 0) 1 0)
           (helper (+ k 1)))))
  (helper 1))