(define (my-sqrt x)
  (cond [(<= x 1) x]
        [else
         (let loop ([low 1] [high x])
           (if (<= low high)
               (let ([mid (floor (+ low high) 2)])
                 (cond [(<= (* mid mid) x (< x (* (+ mid 1) (+ mid 1)))) mid]
                       [(< (* mid mid) x) (loop (+ mid 1) high)]
                       [else (loop low (- mid 1))]))
               high))]))