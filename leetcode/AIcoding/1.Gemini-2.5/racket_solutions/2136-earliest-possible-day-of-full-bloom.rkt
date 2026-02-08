(define (earliest-possible-day-of-full-bloom plantTime growTime)
  (define flowers
    (map list growTime plantTime))

  (define sorted-flowers
    (sort flowers (lambda (f1 f2)
                    (> (car f1) (car f2)))))

  (define initial-accumulator (list 0 0)) ; (current-plant-time max-bloom-time)

  (define final-accumulator
    (foldl (lambda (flower acc)
             (define grow (car flower))
             (define plant (cadr flower))

             (define current-plant-time (car acc))
             (define max-bloom-time (cadr acc))

             (define new-current-plant-time (+ current-plant-time plant))
             (define bloom-time-for-this-flower (+ new-current-plant-time grow))
             (define new-max-bloom-time (max max-bloom-time bloom-time-for-this-flower))

             (list new-current-plant-time new-max-bloom-time))
           initial-accumulator
           sorted-flowers))

  (cadr final-accumulator))