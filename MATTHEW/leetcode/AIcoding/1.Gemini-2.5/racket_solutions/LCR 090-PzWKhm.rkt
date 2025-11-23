(define (rob nums)
  (define (rob-linear houses)
    (let loop ((h houses)
               (prev2 0)
               (prev1 0))
      (if (empty? h)
          prev1
          (let* ((current-house (car h))
                 (current-max (max prev1 (+ prev2 current-house))))
            (loop (cdr h)
                  prev1
                  current-max)))))

  (cond
    ((empty? nums) 0)
    ((= (length nums) 1) (car nums))
    (else
     (let* ((n (length nums))
            (res1 (rob-linear (take nums (- n 1))))
            (res2 (rob-linear (drop nums 1))))
       (max res1 res2)))))