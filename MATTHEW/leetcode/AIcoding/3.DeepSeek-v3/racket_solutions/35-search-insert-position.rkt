(define/contract (search-insert nums target)
  (-> (listof exact-integer?) exact-integer? exact-integer?)
  (let loop ([left 0] [right (- (length nums) 1)])
    (if (> left right)
        left
        (let* ([mid (quotient (+ left right) 2)]
               [mid-val (list-ref nums mid)])
          (cond
            [(= mid-val target) mid]
            [(< mid-val target) (loop (+ mid 1) right)]
            [else (loop left (- mid 1))])))))