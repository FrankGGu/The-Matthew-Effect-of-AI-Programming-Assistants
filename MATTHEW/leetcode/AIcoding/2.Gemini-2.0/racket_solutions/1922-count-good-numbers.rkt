(define (count-good-numbers n)
  (define mod 1000000007)

  (define (pow x y)
    (cond ((= y 0) 1)
          ((even? y) (modulo (* (pow x (/ y 2)) (pow x (/ y 2))) mod))
          (else (modulo (* x (pow x (- y 1))) mod))))

  (modulo (* (pow 5 (+ (quotient n 2) (modulo n 2))) (pow 4 (quotient n 2))) mod))