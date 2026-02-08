(define (climb-stairs n)
  (cond
    ((= n 1) 1)
    ((= n 2) 2)
    (else
     (let loop ((i 3)
                (prev1 1)
                (prev2 2))
       (if (> i n)
           prev2
           (loop (+ i 1)
                 prev2
                 (+ prev1 prev2)))))))