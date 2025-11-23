(define/contract (ship-within-days weights days)
  (-> (listof exact-integer?) exact-integer? exact-integer?)
  (define (can-ship capacity)
    (let loop ([ws weights] [current 0] [d days])
      (cond
        [(null? ws) #t]
        [(> current (car ws)) #f]
        [(> (+ current (car ws)) capacity)
         (if (<= d 1) #f (loop (cdr ws) (car ws) (sub1 d))))]
        [else (loop (cdr ws) (+ current (car ws)) d)])))

  (let binary-search ([left (apply max weights)] [right (apply + weights)])
    (if (= left right)
        left
        (let ([mid (quotient (+ left right) 2)])
          (if (can-ship mid)
              (binary-search left mid)
              (binary-search (add1 mid) right))))))
)