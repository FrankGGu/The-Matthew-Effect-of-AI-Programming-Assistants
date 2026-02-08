(define (min-difference-between-largest-and-smallest-value-in-three-moves nums)
  (let* ([n (length nums)]
         [sorted-nums (sort nums <)])
    (cond
      [(<= n 4) 0]
      [else
       (min
        (- (list-ref sorted-nums (- n 1)) (list-ref sorted-nums 3))
        (- (list-ref sorted-nums (- n 2)) (list-ref sorted-nums 2))
        (- (list-ref sorted-nums (- n 3)) (list-ref sorted-nums 1))
        (- (list-ref sorted-nums (- n 4)) (list-ref sorted-nums 0)))])))