(define (can-complete-training plan)
  (define (helper plan index energy)
    (if (>= index (length plan))
        #t
        (let ((current (list-ref plan index)))
          (if (>= energy current)
              (helper plan (+ index 1) (- energy current))
              #f))))
  (helper plan 0 0))

(define (trainingPlanVI plan)
  (define (calculate-energy plan)
    (foldl (lambda (x acc) (+ acc x)) 0 plan))
  (define total-energy (calculate-energy plan))
  (if (can-complete-training plan)
      total-energy
      -1))