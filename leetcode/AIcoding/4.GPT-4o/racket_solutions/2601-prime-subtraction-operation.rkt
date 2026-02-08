(define (prime-subtraction-operation n)
  (define (is-prime x)
    (if (< x 2) #f
        (let loop ((i 2))
          (if (> i (sqrt x)) #t
              (if (= (modulo x i) 0) #f
                  (loop (+ i 1)))))))

  (define (generate-primes limit)
    (filter is-prime (range 2 (add1 limit))))

  (define primes (generate-primes n))

  (define (can-reach-zero current)
    (if (= current 0) #t
        (and (positive? current)
             (for/or ([p primes])
               (can-reach-zero (- current p))))))

  (can-reach-zero n))