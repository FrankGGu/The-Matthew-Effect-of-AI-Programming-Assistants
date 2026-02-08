(define (closest-primes left right)
  (define (prime? n)
    (if (<= n 1)
        #f
        (if (<= n 3)
            #t
            (if (or (zero? (remainder n 2)) (zero? (remainder n 3)))
                #f
                (let loop ([i 5])
                  (if (> (* i i) n)
                      #t
                      (if (or (zero? (remainder n i)) (zero? (remainder n (+ i 2))))
                          #f
                          (loop (+ i 6)))))))))

  (let loop ([i left] [primes '()] [last-prime -1] [min-diff +inf.0] [result '(-1 -1)])
    (cond
      [(> i right) (if (equal? result '(-1 -1)) '(-1 -1) result)]
      [(prime? i)
       (if (= last-prime -1)
           (loop (+ i 1) primes i min-diff result)
           (let ([diff (- i last-prime)])
             (if (< diff min-diff)
                 (loop (+ i 1) (cons i primes) i diff (list last-prime i))
                 (loop (+ i 1) (cons i primes) i min-diff result))))]
      [else (loop (+ i 1) primes last-prime min-diff result)]))))