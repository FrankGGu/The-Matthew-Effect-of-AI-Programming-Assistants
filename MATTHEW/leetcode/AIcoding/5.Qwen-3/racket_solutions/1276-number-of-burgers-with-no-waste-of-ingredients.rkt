(define (num-bergs total-ingredients)
  (let* ([total (car total-ingredients)]
         [max-x (quotient total 2)]
         [min-x (quotient total 3)])
    (let loop ([x min-x])
      (cond [(> x max-x) #f]
            [(= (modulo (- total (* 2 x)) 3) 0)
             (let ([y (/ (- total (* 2 x)) 3)])
               (if (and (>= y 0) (<= y x))
                   (list x y)
                   (loop (+ x 1))))]
            [else (loop (+ x 1))]))))