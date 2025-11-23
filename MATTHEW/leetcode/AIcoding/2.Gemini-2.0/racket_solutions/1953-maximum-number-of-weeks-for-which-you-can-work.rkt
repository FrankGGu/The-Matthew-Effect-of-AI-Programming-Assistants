(define (max-weeks milestones)
  (let* ([total-sum (apply + milestones)]
         [max-value (apply max milestones)]
         [rest-sum (- total-sum max-value)])
    (if (> max-value rest-sum)
        (+ (* 2 rest-sum) 1)
        total-sum)))