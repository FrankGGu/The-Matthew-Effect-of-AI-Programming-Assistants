(define (first-bad-version n)
  (let loop ([left 1] [right n])
    (if (= left right)
        left
        (let ([mid (quotient (+ left right) 2)])
          (if (isBadVersion mid)
              (loop left mid)
              (loop (+ mid 1) right))))))