(define (prime-pairs target)
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

  (define (find-pairs n)
    (cond
      [(<= n 1) '()]
      [else
       (let ([complement (- target n)])
         (cond
           [(and (>= complement n) (is-prime? n) (is-prime? complement))
            (cons (list n complement) (find-pairs (+ n 1)))]
           [else (find-pairs (+ n 1))]))]))

  (sort (find-pairs 2) < #:key car))