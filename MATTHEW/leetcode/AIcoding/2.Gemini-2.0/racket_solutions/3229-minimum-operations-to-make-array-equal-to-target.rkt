(define (minOperations nums target)
  (let loop ((nums nums) (target target) (ops 0))
    (cond
      [(empty? nums) (if (= target 0) ops #f)]
      [(= target 0) ops]
      [(and (empty? nums) (> target 0)) #f]
      [else
       (let* ((n (car nums))
              (rest (cdr nums))
              (op1 (if (>= target n) (loop rest (- target n) (+ ops 1)) #f))
              (op2 (loop rest target ops)))
         (cond
           [(and op1 op2) (min op1 op2)]
           [op1 op1]
           [op2 op2]
           [else #f]))])))