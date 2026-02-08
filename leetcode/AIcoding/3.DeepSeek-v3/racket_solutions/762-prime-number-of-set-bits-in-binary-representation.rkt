(define/contract (count-prime-set-bits left right)
  (-> exact-integer? exact-integer? exact-integer?)
  (define (count-bits n)
    (let loop ([n n] [count 0])
      (if (zero? n)
          count
          (loop (bitwise-and n (sub1 n)) (add1 count))))
  (define (is-prime? n)
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
  (let loop ([i left] [count 0])
    (if (> i right)
        count
        (let ([bits (count-bits i)])
          (loop (add1 i) (if (is-prime? bits) (add1 count) count))))))