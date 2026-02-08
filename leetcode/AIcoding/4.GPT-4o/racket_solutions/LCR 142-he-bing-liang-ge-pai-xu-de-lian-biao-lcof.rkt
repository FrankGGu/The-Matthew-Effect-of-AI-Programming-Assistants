(define (canCompleteTrainingPlan A T)
  (define (helper A T days)
    (if (or (zero? T) (>= days (length A)))
        (>= T 0)
        (let ((current (list-ref A days)))
          (or (helper A (- T current) (+ days 1))
              (helper A T (+ days 1))))))
  (helper A T 0))

(define (trainingPlan IV A T)
  (if (canCompleteTrainingPlan A T)
      #t
      #f))