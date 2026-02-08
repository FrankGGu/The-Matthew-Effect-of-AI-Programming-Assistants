(define (maximum-prime-difference nums)
  (define (is-prime? n)
    (cond
      [(<= n 1) #f]
      [(= n 2) #t]
      [(even? n) #f]
      [else
       (let loop ([i 3])
         (cond
           [(> (* i i) n) #t]
           [(zero? (remainder n i)) #f]
           [else (loop (+ i 2))]))]))

  (define primes (filter is-prime? nums))

  (if (null? primes)
      -1
      (let ([min-prime (apply min primes)]
            [max-prime (apply max primes)])
        (if (= min-prime max-prime)
            -1
            (- max-prime min-prime)))))