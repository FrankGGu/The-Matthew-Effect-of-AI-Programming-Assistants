(define (split-array nums)
  (let* ([n (length nums)]
         [total-sum (apply + nums)]
         (define (helper index current-sum)
           (cond
             [(>= index n) #f]
             [(= current-sum (- total-sum current-sum)) #t]
             [else (or (helper (+ index 1) current-sum)
                       (helper (+ index 1) (+ current-sum (list-ref nums index))))]))
    (helper 0 0)))