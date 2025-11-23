(define (search nums target)
  (define (helper left right)
    (cond [(> left right) #f]
          [else
           (let ([mid (quotient (+ left right) 2)])
             (if (= (list-ref nums mid) target)
                 #t
                 (cond [(< (list-ref nums left) (list-ref nums mid))
                        (if (and (<= (list-ref nums left) target) (< target (list-ref nums mid)))
                            (helper left (sub1 mid))
                            (helper (add1 mid) right))]
                       [(> (list-ref nums left) (list-ref nums mid))
                        (if (and (<= (list-ref nums left) target) (> target (list-ref nums mid)))
                            (helper (add1 mid) right)
                            (helper left (sub1 mid)))]
                       [else (helper (add1 left) right)]))]))
  (helper 0 (sub1 (length nums))))