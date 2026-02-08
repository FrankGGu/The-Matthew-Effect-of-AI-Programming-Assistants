(define (num-prime-arrangements n)
  (define (is-prime? x)
    (and (> x 1)
         (not (or (for/or ([i (in-range 2 (add1 (floor (sqrt x))))] 
                             (zero? (remainder x i)))))))
  (define (count-primes up-to)
    (length (filter is-prime? (range 2 (add1 up-to)))))
  (define mod (expt 10 9))
  (define primes (count-primes n))
  (define factorial (lambda (x)
                      (if (zero? x) 1
                          (modulo (* x (factorial (sub1 x))) mod))))
  (modulo (* (factorial primes) (factorial (- n primes))) mod))

(define (main)
  (num-prime-arrangements 5))

(main)