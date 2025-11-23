(define (search nums target)
  (define (helper left right)
    (cond
      [(> left right) #f]
      [else
       (let* ([mid (quotient (+ left right) 2)]
              [mid-val (list-ref nums mid)])
         (cond
           [(= mid-val target) #t]
           [(= (list-ref nums left) mid-val) (helper (+ left 1) right)]
           [(< (list-ref nums left) mid-val)
            (cond
              [(and (>= target (list-ref nums left)) (< target mid-val)) (helper left (- mid 1))]
              [else (helper (+ mid 1) right)])]
           [else
            (cond
              [(and (> target mid-val) (<= target (list-ref nums right))) (helper (+ mid 1) right)]
              [else (helper left (- mid 1))])]))]))
  (helper 0 (- (length nums) 1)))