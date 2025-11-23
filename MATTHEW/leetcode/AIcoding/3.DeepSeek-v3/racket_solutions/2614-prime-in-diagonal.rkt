(define/contract (diagonal-prime nums)
  (-> (listof (listof exact-integer?)) exact-integer?)
  (define (prime? n)
    (cond
      [(<= n 1) #f]
      [(= n 2) #t]
      [(even? n) #f]
      [else
       (let loop ([i 3])
         (cond
           [(> (* i i) n) #t]
           [(zero? (modulo n i)) #f]
           [else (loop (+ i 2))]))]))
  (let ([n (length nums)])
    (let loop ([i 0] [max-prime 0])
      (if (>= i n)
          max-prime
          (let* ([j1 i]
                 [j2 (- n 1 i)]
                 [num1 (list-ref (list-ref nums i) j1)]
                 [num2 (list-ref (list-ref nums i) j2)]
                 [new-max (cond
                           [(and (prime? num1) (prime? num2)) (max num1 num2 max-prime)]
                           [(prime? num1) (max num1 max-prime)]
                           [(prime? num2) (max num2 max-prime)]
                           [else max-prime])])
            (loop (+ i 1) new-max))))))