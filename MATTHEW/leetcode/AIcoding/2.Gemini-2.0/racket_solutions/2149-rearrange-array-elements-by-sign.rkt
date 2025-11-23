(define (rearrange-array nums)
  (let* ([pos (filter (lambda (x) (> x 0)) nums)]
         [neg (filter (lambda (x) (< x 0)) nums)]
         [result '()])
    (for ([i (in-range (length pos))])
      (set! result (append result (list (list-ref pos i) (list-ref neg i)))))
    result))