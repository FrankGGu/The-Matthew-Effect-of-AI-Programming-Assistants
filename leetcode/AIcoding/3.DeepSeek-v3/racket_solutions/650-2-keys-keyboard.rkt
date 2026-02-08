(define (min-steps n)
  (let loop ([n n] [res 0] [div 2])
    (cond
      [(= n 1) res]
      [(zero? (modulo n div))
       (loop (/ n div) (+ res div) div)]
      [else
       (loop n res (+ div 1))])))