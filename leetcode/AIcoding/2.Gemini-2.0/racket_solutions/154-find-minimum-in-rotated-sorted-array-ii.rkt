(define (find-min nums)
  (let loop ([left 0] [right (- (length nums) 1)])
    (cond
      [(= left right) (list-ref nums left)]
      [(< left right)
       (let ([mid (quotient (+ left right) 2)])
         (cond
           [(< (list-ref nums mid) (list-ref nums right))
            (loop left mid)]
           [(> (list-ref nums mid) (list-ref nums right))
            (loop (+ mid 1) right)]
           [else
            (loop left (- right 1))]))]
      [else #f])))