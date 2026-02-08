(define (closest-primes left right)
  (define (is-prime? n)
    (cond
      [(<= n 1) #f]
      [(= n 2) #t]
      [(even? n) #f]
      [else
       (let loop ([i 3])
         (cond
           [(> (* i i) n) #t]
           [(= (remainder n i) 0) #f]
           [else (loop (+ i 2))]))]))

  (define primes (filter is-prime? (range left (+ right 1))))

  (if (< (length primes) 2)
      '(-1 -1)
      (let loop ([primes primes] [min-diff #f] [result '(-1 -1)])
        (cond
          [(null? (cdr primes)) result]
          [else
           (let ([p1 (car primes)] [p2 (cadr primes)] [diff (- p2 p1)])
             (if (or (not min-diff) (< diff min-diff))
                 (loop (cdr primes) diff (list p1 p2))
                 (loop (cdr primes) min-diff result))))))))