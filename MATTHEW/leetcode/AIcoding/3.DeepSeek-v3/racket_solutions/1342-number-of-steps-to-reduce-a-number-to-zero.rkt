(define (number-of-steps num)
  (let loop ([n num] [steps 0])
    (cond
      [(zero? n) steps]
      [(even? n) (loop (/ n 2) (add1 steps))]
      [else (loop (sub1 n) (add1 steps))])))