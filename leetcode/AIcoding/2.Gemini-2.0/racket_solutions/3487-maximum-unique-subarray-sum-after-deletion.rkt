(define (maximum-unique-subarray-sum nums)
  (define (helper nums start end current-sum current-set max-sum)
    (cond
      [(>= start (length nums)) max-sum]
      [(>= end (length nums)) max-sum]
      [(set-member? current-set (list-ref nums end))
       (helper nums (+ start 1) (+ start 1) 0 (set) max-sum)]
      [else
       (let* ([new-current-sum (+ current-sum (list-ref nums end))]
              [new-current-set (set-add current-set (list-ref nums end))]
              [new-max-sum (max max-sum new-current-sum)])
         (helper nums start (+ end 1) new-current-sum new-current-set new-max-sum))]))

  (helper nums 0 0 0 (set) 0))