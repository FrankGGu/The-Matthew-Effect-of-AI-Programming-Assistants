(define (search-insert nums target)
  (let loop ([left 0] [right (- (length nums) 1)])
    (if (> left right)
        left
        (let ([mid (floor (/ (+ left right) 2))])
          (cond
            [(= (list-ref nums mid) target) mid]
            [(< (list-ref nums mid) target) (loop (+ mid 1) right)]
            [else (loop left (- mid 1))])))))