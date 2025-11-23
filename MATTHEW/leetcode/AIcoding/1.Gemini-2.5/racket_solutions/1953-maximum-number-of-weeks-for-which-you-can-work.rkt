(define (maximum-weeks milestones)
  (let* ((total-tasks (apply + milestones))
         (max-tasks (apply max milestones))
         (other-tasks-sum (- total-tasks max-tasks)))
    (if (<= max-tasks (+ other-tasks-sum 1))
        total-tasks
        (+ (* 2 other-tasks-sum) 1))))