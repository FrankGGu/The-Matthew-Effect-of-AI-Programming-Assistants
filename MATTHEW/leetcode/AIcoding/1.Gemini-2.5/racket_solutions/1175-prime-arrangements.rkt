(define (num-prime-arrangements n)
  (define MOD 1000000007)

  (define (prime? k)
    (cond
      ((< k 2) #f)
      ((= k 2) #t)
      ((even? k) #f)
      (else
       (let loop ((d 3))
         (cond
           ((> (* d d) k) #t)
           ((zero? (remainder k d)) #f)
           (else (loop (+ d 2))))))))

  (define (count-primes-up-to n)
    (let loop ((i 1) (count 0))
      (if (> i n)
          count
          (loop (+ i 1) (if (prime? i) (+ count 1) count)))))

  (define (factorial-mod k)
    (let loop ((i 1) (res 1))
      (if (> i k)
          res
          (loop (+ i 1) (remainder (* res i) MOD)))))

  (let* ((num-primes (count-primes-up-to n))
         (num-non-primes (- n num-primes)))
    (remainder (* (factorial-mod num-primes)
                  (factorial-mod num-non-primes))
               MOD)))