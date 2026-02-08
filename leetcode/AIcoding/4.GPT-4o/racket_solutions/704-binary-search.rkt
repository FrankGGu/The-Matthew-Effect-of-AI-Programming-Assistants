(define (search nums target)
  (define (binary-search left right)
    (if (> left right)
        -1
        (let ((mid (quotient (+ left right) 2)))
          (cond ((= (list-ref nums mid) target) mid)
                ((< (list-ref nums mid) target) (binary-search (+ mid 1) right))
                (else (binary-search left (- mid 1)))))))
  (binary-search 0 (- (length nums) 1)))