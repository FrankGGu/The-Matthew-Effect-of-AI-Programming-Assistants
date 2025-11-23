(define (punishment-number n)
  (define (is-punishment-number k)
    (define (sum-of-squares x)
      (if (= x 0)
          0
          (+ (modulo x 10) (sum-of-squares (quotient x 10)))))
    (= (sum-of-squares k) (expt (floor (sqrt k)) 2)))
  (define (find-punishment-sum m acc)
    (if (= m 0)
        acc
        (find-punishment-sum (sub1 m) 
                             (if (is-punishment-number m) 
                                 (+ acc m) 
                                 acc))))
  (find-punishment-sum n 0))

(define (punishment-number-main n)
  (punishment-number n))