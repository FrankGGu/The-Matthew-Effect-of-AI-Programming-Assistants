(define (expected-number-of-students n arr)
  (let loop ([nums (sort arr <)]
             [count 0]
             [last -1])
    (cond
      [(empty? nums) count]
      [else
       (if (> (car nums) last)
           (loop (cdr nums) (+ count 1) (car nums))
           (loop (cdr nums) count last))])))