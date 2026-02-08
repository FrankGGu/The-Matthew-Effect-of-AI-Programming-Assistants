(define (pow base exp mod)
  (let loop ((b base) (e exp) (res 1))
    (if (= e 0) res
        (loop (modulo (* b b) mod)
              (quotient e 2)
              (if (odd? e) (modulo (* res b) mod) res)))))

(define (max-nice-divisors primeFactors)
  (let ((MOD 1000000007))
    (cond
      ((= primeFactors 1) 1)
      ((= primeFactors 2) 2)
      ((= primeFactors 3) 3)
      ((= (modulo primeFactors 3) 0)
       (pow 3 (quotient primeFactors 3) MOD))
      ((= (modulo primeFactors 3) 1)
       (modulo (* 4 (pow 3 (quotient (- primeFactors 4) 3) MOD)) MOD))
      ((= (modulo primeFactors 3) 2)
       (modulo (* 2 (pow 3 (quotient (- primeFactors 2) 3) MOD)) MOD)))))