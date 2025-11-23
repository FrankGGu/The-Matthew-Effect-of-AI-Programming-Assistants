(define (isHarshad n)
  (define (sum-of-digits x)
    (if (= x 0)
        0
        (+ (modulo x 10) (sum-of-digits (quotient x 10)))))
  (if (= n 0)
      #f
      (= (modulo n (sum-of-digits n)) 0)))