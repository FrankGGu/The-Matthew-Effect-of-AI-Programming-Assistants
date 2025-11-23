(define (can-split-array nums m)
  (if (<= (length nums) 2)
      #t
      (let loop ([lst (cdr nums)]
                 [prev (car nums)])
        (cond [(null? lst) #f]
              [(>= (+ prev (car lst)) m) #t]
              [else (loop (cdr lst) (+ prev (car lst)))]))))