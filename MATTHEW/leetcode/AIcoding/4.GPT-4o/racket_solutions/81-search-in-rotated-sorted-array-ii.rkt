(define (search nums target)
  (define (binary-search left right)
    (if (> left right)
        #f
        (let* ((mid (quotient (+ left right) 2))
               (mid-val (list-ref nums mid)))
          (cond
            ((= mid-val target) #t)
            ((and (= (list-ref nums left) mid-val) (= (list-ref nums right) mid-val))
             (or (binary-search (+ left 1) right) (binary-search left (- right 1))))
            ((< mid-val (list-ref nums right))
             (if (< mid-val target)
                 (binary-search (+ mid 1) right)
                 (binary-search left (- mid 1))))
            (else
             (if (> mid-val target)
                 (binary-search left (- mid 1))
                 (binary-search (+ mid 1) right)))))))
  (binary-search 0 (- (length nums) 1)))