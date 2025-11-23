(define (max-frequency nums k)
  (define (helper nums k left right sum max-freq)
    (cond
      [(>= right (length nums)) max-freq]
      [else
       (let* ([curr-sum (+ sum (list-ref nums right))]
              [curr-len (+ 1 (- right left))])
         (if (>= (* (list-ref nums right) curr-len) curr-sum)
             (helper nums k left (+ 1 right) curr-sum (max max-freq curr-len))
             (let ([new-sum (- curr-sum (list-ref nums left))])
               (if (>= k (+ k (- (* (list-ref nums right) curr-len) curr-sum)))
                   (helper nums k (+ 1 left) right new-sum max-freq)
                   (helper nums k (+ 1 left) right new-sum max-freq)))))]))

  (let ([sorted-nums (sort nums <)])
    (helper sorted-nums k 0 0 0 0)))