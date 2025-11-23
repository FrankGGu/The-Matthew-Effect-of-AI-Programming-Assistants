(define (find-target-sum-ways nums target)
  (define (helper nums index current-sum)
    (cond
      [(equal? index (length nums))
       (if (equal? current-sum target) 1 0)]
      [else
       (+ (helper nums (+ index 1) (+ current-sum (list-ref nums index)))
          (helper nums (+ index 1) (- current-sum (list-ref nums index))))]))
  (helper nums 0 0))