(define/contract (maximum-prime-difference nums)
  (-> (listof exact-integer?) exact-integer?)
  (define (prime? n)
    (cond
      [(<= n 1) #f]
      [(<= n 3) #t]
      [(zero? (modulo n 2)) #f]
      [else
       (let loop ([i 3])
         (cond
           [(> (* i i) n) #t]
           [(zero? (modulo n i)) #f]
           [else (loop (+ i 2))]))]))
  (let loop ([i 0] [first-prime -1] [last-prime -1])
    (cond
      [(= i (length nums)) (- last-prime first-prime)]
      [(prime? (list-ref nums i))
       (if (= first-prime -1)
           (loop (+ i 1) i i)
           (loop (+ i 1) first-prime i))]
      [else (loop (+ i 1) first-prime last-prime)])))