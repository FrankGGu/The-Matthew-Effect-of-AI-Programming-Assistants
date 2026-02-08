(define (distinct-primes n)
  (let loop ((n n) (primes '()) (i 2))
    (cond
      ((= n 1) (list->set primes))
      ((> (* i i) n) (list->set (cons n primes)))
      ((zero? (modulo n i)) (loop (/ n i) (cons i primes) i))
      (else (loop n primes (+ i 1))))))

(define (max-distinct-primes nums)
  (define n (length nums))
  (define (solve idx left-primes)
    (cond
      ((= idx n) (length left-primes))
      (else
       (let ((right-primes (distinct-primes (list-ref nums idx))))
         (max (solve (+ idx 1) (set-union left-primes right-primes))
              (if (null? left-primes)
                  0
                  (+ (length left-primes) (solve (+ idx 1) right-primes))))))))

  (solve 0 '()))