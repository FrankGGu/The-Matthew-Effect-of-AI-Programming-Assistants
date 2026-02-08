(define (closest-prime-numbers low high)
  (define (is-prime n)
    (if (< n 2) #f
        (let loop ((i 2))
          (cond ((> i (sqrt n)) #t)
                ((= (mod n i) 0) #f)
                (else (loop (+ i 1)))))))

  (define primes
    (filter is-prime (range low (+ high 1))))

  (if (null? primes)
      (list -1 -1)
      (let* ((closest (list (car primes) (car (reverse primes)))))
        (if (or (null? (cdr primes)) (null? (cddr primes)))
            closest
            (let loop ((p1 (car closest)) (p2 (cadr closest)) (min-diff +inf.0) (result closest))
              (for ((p (cdr primes)))
                (let* ((diff1 (abs (- p p1)))
                       (diff2 (abs (- p p2))))
                  (when (< diff1 min-diff)
                    (set! min-diff diff1)
                    (set! result (list p1 p))))
              result))))))