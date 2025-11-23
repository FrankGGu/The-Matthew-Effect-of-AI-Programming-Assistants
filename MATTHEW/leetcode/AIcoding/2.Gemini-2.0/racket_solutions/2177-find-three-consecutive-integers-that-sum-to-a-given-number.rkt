(define (sum-of-three-consecutive-integers num)
  (cond
    [(integer? num)
     (let ((x (/ num 3)))
       (cond
         [(= (remainder num 3) 0)
          (list (- x 1) x (+ x 1))]
         [else '()])
       )]
    [else '()])
  )