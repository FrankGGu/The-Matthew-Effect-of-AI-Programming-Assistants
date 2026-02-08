(define (numOfWays n x)
  (define (modular-exponentiation base exp mod)
    (if (= exp 0)
        1
        (let ((half (modular-exponentiation base (quotient exp 2) mod)))
          (if (even? exp)
              (modulo (* half half) mod)
              (modulo (* base (modulo (* half half) mod)) mod)))))

  (define mod 1000000007)
  (define total-ways (modular-exponentiation 2 n mod))
  (define invalid-ways (modular-exponentiation (modulo x mod) n mod))
  (modulo (- total-ways invalid-ways) mod))

(numOfWays n x)