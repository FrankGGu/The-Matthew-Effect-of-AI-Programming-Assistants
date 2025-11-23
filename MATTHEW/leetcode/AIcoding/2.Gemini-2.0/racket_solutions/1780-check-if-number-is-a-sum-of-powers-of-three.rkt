(define (check-if-number-is-sum-of-powers-of-three n)
  (cond
    [(zero? n) #t]
    [(odd? n) (if (= (modulo n 3) 1)
                  (check-if-number-is-sum-of-powers-of-three (quotient n 3))
                  #f)]
    [else (if (= (modulo n 3) 0)
              (check-if-number-is-sum-of-powers-of-three (quotient n 3))
              #f)]))