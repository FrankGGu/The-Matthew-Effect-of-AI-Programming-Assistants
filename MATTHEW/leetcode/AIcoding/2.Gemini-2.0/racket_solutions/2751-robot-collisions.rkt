(define (robot-collisions s h dir)
  (let loop ([stack '()]
             [result '()])
    (cond
      [(empty? s)
       (reverse result)]
      [else
       (let ([idx (car s)]
             [height (list-ref h idx)]
             [direction (list-ref dir idx)])
         (cond
           [(empty? stack)
            (loop (cdr s) (cons idx result))]
           [else
            (let ([top-idx (car stack)]
                  [top-height (list-ref h top-idx)]
                  [top-direction (list-ref dir top-idx)])
              (cond
                [(= direction "R")
                 (loop (cons idx stack) (cdr s) result)]
                [(= top-direction "L")
                 (loop (cdr s) (cons idx result))]
                [else
                 (cond
                   [(> height top-height)
                    (loop s (cdr stack) result)]
                   [(< height top-height)
                    (loop (cdr s) (cdr stack) (cons top-idx result))]
                   [else
                    (loop (cdr s) (cdr stack) result)]))]))])]))))