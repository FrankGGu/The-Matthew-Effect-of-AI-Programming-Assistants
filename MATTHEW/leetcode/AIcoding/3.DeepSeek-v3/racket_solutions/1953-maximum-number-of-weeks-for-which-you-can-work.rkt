(define/contract (number-of-weeks milestones)
  (-> (listof exact-integer?) exact-integer?)
  (let* ([max-milestone (apply max milestones)]
         [sum-others (- (apply + milestones) max-milestone)])
    (if (<= max-milestone (+ sum-others 1))
        (apply + milestones)
        (+ (* sum-others 2) 1))))