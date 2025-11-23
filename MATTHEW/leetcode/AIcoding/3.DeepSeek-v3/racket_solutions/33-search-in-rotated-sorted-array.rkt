(define/contract (search nums target)
  (-> (listof exact-integer?) exact-integer? exact-integer?)
  (let loop ([left 0] [right (sub1 (length nums))])
    (if (> left right)
        -1
        (let* ([mid (quotient (+ left right) 2)]
               [mid-val (list-ref nums mid)])
          (cond
            [(= mid-val target) mid]
            [(<= (list-ref nums left) mid-val)
             (if (and (<= (list-ref nums left) target) (< target mid-val))
                 (loop left (sub1 mid))
                 (loop (add1 mid) right))]
            [else
             (if (and (> target mid-val) (<= target (list-ref nums right)))
                 (loop (add1 mid) right)
                 (loop left (sub1 mid)))])))))