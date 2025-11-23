(define/contract (search nums target)
  (-> (listof exact-integer?) exact-integer? boolean?)
  (let loop ([left 0] [right (sub1 (length nums))])
    (if (> left right)
        #f
        (let* ([mid (quotient (+ left right) 2)]
               [mid-val (list-ref nums mid)])
          (cond
            [(= mid-val target) #t]
            [(< (list-ref nums left) mid-val)
             (if (and (<= (list-ref nums left) target) (< target mid-val))
                 (loop left (sub1 mid))
                 (loop (add1 mid) right))]
            [(> (list-ref nums left) mid-val)
             (if (and (> target mid-val) (<= target (list-ref nums right)))
                 (loop (add1 mid) right)
                 (loop left (sub1 mid)))]
            [else (loop (add1 left) right)])))))