(define (find-error-nums nums)
  (let* ([n (length nums)]
         [sum-nums (apply + nums)]
         [sum-set (apply + (remove-duplicates nums))]
         [expected-sum (/ (* n (+ n 1)) 2)]
         [duplicate (- sum-nums sum-set)]
         [missing (+ expected-sum (- sum-set))]
         )
    (list duplicate missing)))