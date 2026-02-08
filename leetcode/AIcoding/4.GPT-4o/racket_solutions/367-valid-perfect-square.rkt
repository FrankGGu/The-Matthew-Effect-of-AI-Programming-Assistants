(define (isPerfectSquare num)
  (define (binary-search left right)
    (if (> left right)
        #f
        (let* ((mid (quotient (+ left right) 2))
               (square (* mid mid)))
          (cond
            ((= square num) #t)
            ((< square num) (binary-search (+ mid 1) right))
            (else (binary-search left (- mid 1)))))))
  (if (< num 0) #f (binary-search 0 num)))