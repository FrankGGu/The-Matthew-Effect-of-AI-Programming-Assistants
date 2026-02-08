(define (integer-break n)
  (cond
    [(= n 2) 1]
    [(= n 3) 2]
    [else
     (let loop ([n n] [product 1])
       (cond
         [(> n 4) (loop (- n 3) (* product 3))]
         [(= n 4) (* product 4)]
         [(= n 3) (* product 3)]
         [(= n 2) (* product 2)]))]))