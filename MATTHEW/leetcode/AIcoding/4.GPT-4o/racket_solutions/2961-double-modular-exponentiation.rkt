(define (modular-exponentiation base exp mod)
  (define (helper base exp mod result)
    (cond
      [(= exp 0) result]
      [(odd? exp) (helper base (sub1 exp) mod (modulo (* base result) mod))]
      [else (helper (modulo (* base base) mod) (/ exp 2) mod result)]))
  (helper base exp mod 1))

(define (double-modular-exponentiation a b c d e mod)
  (values (modular-exponentiation a b mod) (modular-exponentiation c d mod)))

(double-modular-exponentiation a b c d e mod)