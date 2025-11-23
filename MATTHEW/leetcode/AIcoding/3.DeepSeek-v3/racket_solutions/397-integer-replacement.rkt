(define (integer-replacement n)
  (let loop ([n n] [steps 0])
    (cond
      [(= n 1) steps]
      [(even? n) (loop (/ n 2) (add1 steps))]
      [else (min (loop (add1 n) (add1 steps))
                 (loop (sub1 n) (add1 steps)))])))