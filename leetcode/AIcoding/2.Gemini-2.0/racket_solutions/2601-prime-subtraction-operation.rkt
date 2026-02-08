(define (prime-subtraction-operation nums)
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

  (define (find-largest-prime-less-than n)
    (let loop ([i (- n 1)])
      (cond
        [(<= i 1) 0]
        [(is-prime? i) i]
        [else (loop (- i 1))])))

  (define (solve nums)
    (let loop ([nums nums] [prev -1])
      (cond
        [(null? nums) #t]
        [else
         (let ([curr (car nums)]
               [rest (cdr nums)])
           (if (>= curr prev)
               (loop rest curr)
               (let ([prime (find-largest-prime-less-than (- curr prev))])
                 (if (zero? prime)
                     #f
                     (loop rest (+ curr (- prime)))))))))))
  (solve nums))