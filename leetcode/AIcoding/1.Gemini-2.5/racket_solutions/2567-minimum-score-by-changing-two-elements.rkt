(define (minimum-score nums)
  (let* ((n (length nums))
         (sorted-nums (sort nums <)))
    (min
     (- (list-ref sorted-nums (- n 1)) (list-ref sorted-nums 2))
     (- (list-ref sorted-nums (- n 3)) (list-ref sorted-nums 0))
     (- (list-ref sorted-nums (- n 2)) (list-ref sorted-nums 1)))))