(define (is-self-crossing distance)
  (define len (length distance))
  (cond [(<= len 3) #f]
        [else
         (let loop ([i 1])
           (if (>= i len)
               #f
               (let ([x (- i 1)]
                     [y i])
                 (if (and (>= x 1)
                          (>= y 1)
                          (<= (list-ref distance x) (list-ref distance (- y 1)))
                          (<= (list-ref distance y) (list-ref distance (- x 1)))
                          (or (<= (list-ref distance (+ x 1)) (list-ref distance (- y 2)))
                              (and (>= y 3)
                                   (<= (list-ref distance (+ x 1)) (list-ref distance (- y 2)))
                                   (<= (list-ref distance y) (list-ref distance (- x 1)))
                                   (<= (list-ref distance x) (list-ref distance (- y 2)))))))
                     #t
                     (loop (+ i 1))))))]))