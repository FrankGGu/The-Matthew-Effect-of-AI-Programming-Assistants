(define (minimum-operations nums)
  (define (helper nums current-height count)
    (cond
      [(empty? nums) count]
      [else
       (let* ([first-num (car nums)]
              [rest-nums (cdr nums)]
              [diff (- first-num current-height)])
         (if (zero? diff)
             (helper rest-nums current-height count)
             (helper rest-nums (+ current-height diff) (+ count 1))))]))
  (helper nums 0 0))