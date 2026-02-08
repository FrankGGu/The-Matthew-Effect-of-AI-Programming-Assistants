(define (find-the-count-of-good-integers n)
  (define MOD 1000000007)

  (define (modular-expt base exp)
    (cond
      ((zero? exp) 1)
      ((even? exp)
       (let ((half (modular-expt base (/ exp 2))))
         (remainder (* half half) MOD)))
      (else
       (remainder (* base (modular-expt base (- exp 1))) MOD))))

  (remainder (* 9 (modular-expt 9 (- n 1))) MOD))