(define (search nums target)
  (define (binary-search left right)
    (if (> left right)
        -1
        (let* ((mid (quotient (+ left right) 2))
               (mid-val (list-ref nums mid)))
          (cond
            ((= mid-val target) mid)
            ((< mid-val target)
             (if (<= (list-ref nums right) mid-val)
                 (binary-search left (- mid 1))
                 (binary-search (+ mid 1) right)))
            (else
             (if (>= (list-ref nums left) mid-val)
                 (binary-search (+ mid 1) right)
                 (binary-search left (- mid 1))))))))
  (binary-search 0 (- (length nums) 1)))