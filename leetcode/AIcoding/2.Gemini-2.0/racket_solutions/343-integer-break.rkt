(define (integer-break n)
  (cond
    [(<= n 3) (- n 1)]
    [else
     (let loop ([n n] [prod 1])
       (cond
         [(= n 0) prod]
         [(<= n 4) (* prod n)]
         [else (loop (- n 3) (* prod 3))]))]))