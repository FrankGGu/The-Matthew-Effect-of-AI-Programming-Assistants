(define/contract (search nums target)
  (-> (listof exact-integer?) exact-integer? exact-integer?)
  (let loop ([left 0] [right (sub1 (length nums))])
    (if (> left right)
        -1
        (let* ([mid (quotient (+ left right) 2)]
               [mid-val (list-ref nums mid)])
          (cond
            [(= mid-val target) mid]
            [(< mid-val target) (loop (add1 mid) right)]
            [else (loop left (sub1 mid))])))))