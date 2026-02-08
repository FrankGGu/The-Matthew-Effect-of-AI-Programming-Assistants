(define (search-insert nums target)
  (let loop ([left 0] [right (sub1 (length nums))])
    (if (> left right)
        left
        (let ([mid (floor (/ (+ left right) 2))])
          (cond
            [(= (list-ref nums mid) target) mid]
            [(< (list-ref nums mid) target) (loop (add1 mid) right)]
            [else (loop left (sub1 mid))])))))