(define/contract (rob nums)
  (-> (listof exact-integer?) exact-integer?)
  (cond
    [(null? nums) 0]
    [(= (length nums) 1) (car nums)]
    [else
     (let loop ([prev1 0] [prev2 0] [rest nums])
       (if (null? rest)
           (max prev1 prev2)
           (loop prev2 (max prev2 (+ prev1 (car rest))) (cdr rest))))]))