(define (superPow a b)
  (define (modular-exponentiation base exp mod)
    (if (= exp 0)
        1
        (let* ((half (modular-exponentiation base (quotient exp 2) mod))
               (half-squared (modulo (* half half) mod)))
          (if (even? exp)
              half-squared
              (modulo (* half-squared base) mod)))))

  (define (super-pow-helper a b)
    (if (null? b)
        1
        (let ((last (car (reverse b)))
              (rest (cdr (reverse b))))
          (modulo (* (super-pow-helper (modulo (modular-exponentiation a 10 (expt 10 9)) 1337) rest) 
                     (modular-exponentiation a last 1337)) 1337))))

  (super-pow-helper a b))

(define (superPow a b)
  (super-pow-helper a b))