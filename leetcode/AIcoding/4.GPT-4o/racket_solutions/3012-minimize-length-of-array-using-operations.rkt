(define (minimizeArrayLength nums)
  (define (helper nums count)
    (if (null? nums)
        count
        (let* ([min-val (apply min nums)]
               [new-nums (filter (lambda (x) (> x min-val))) nums])
          (helper new-nums (add1 count)))))
  (helper nums 0))

(minimizeArrayLength '(3 1 2 1 4))