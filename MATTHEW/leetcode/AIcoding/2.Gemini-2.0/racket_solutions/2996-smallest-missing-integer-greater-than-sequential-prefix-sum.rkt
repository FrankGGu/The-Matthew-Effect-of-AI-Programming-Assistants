(define (smallest-missing-integer nums)
  (define (helper nums prefix-sum current-sum)
    (cond
      [(empty? nums) (add1 current-sum)]
      [(>= (car nums) prefix-sum) current-sum]
      [else (helper (cdr nums) prefix-sum (+ current-sum 1))]))
  (helper nums 1 1))