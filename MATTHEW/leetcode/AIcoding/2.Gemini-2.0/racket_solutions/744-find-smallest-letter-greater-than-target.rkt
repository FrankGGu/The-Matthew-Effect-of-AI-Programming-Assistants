(define (next-greatest-letter letters target)
  (let loop ([left 0] [right (- (length letters) 1)])
    (cond
      [(> left right)
       (list-ref letters (modulo left (length letters)))]
      [else
       (let ([mid (quotient (+ left right) 2)])
         (cond
           [(<= (list-ref letters mid) target)
            (loop (+ mid 1) right)]
           [else
            (loop left (- mid 1))]))])))