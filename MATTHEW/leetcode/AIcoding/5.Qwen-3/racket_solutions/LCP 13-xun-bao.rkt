(define (search-rotated-array nums target)
  (define (find-rotated-index left right)
    (cond [(> left right) -1]
          [else
           (let* ([mid (quotient (+ left right) 2)]
                  [mid-val (list-ref nums mid)])
             (cond [(= mid-val target) mid]
                   [(< (list-ref nums left) mid-val)
                    (if (and (<= (list-ref nums left) target) (< target mid-val))
                        (find-rotated-index left (sub1 mid))
                        (find-rotated-index (add1 mid) right))]
                   [(> (list-ref nums left) mid-val)
                    (if (and (> (list-ref nums left) target) (<= target mid-val))
                        (find-rotated-index left (sub1 mid))
                        (find-rotated-index (add1 mid) right))]))]))
  (find-rotated-index 0 (sub1 (length nums))))