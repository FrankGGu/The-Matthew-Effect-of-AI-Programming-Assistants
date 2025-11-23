(define (minimum-initial-energy tasks)
  (define sorted-tasks
    (sort tasks
          (lambda (task1 task2)
            (> (- (second task1) (first task1))
               (- (second task2) (first task2))))))

  (define result
    (foldl (lambda (task acc)
             (define actual-cost (first task))
             (define minimum-required (second task))
             (define current-initial-energy (first acc))
             (define current-energy (second acc))

             (if (< current-energy minimum-required)
                 (let* ((deficit (- minimum-required current-energy))
                        (new-initial-energy (+ current-initial-energy deficit))
                        (new-current-energy (- minimum-required actual-cost)))
                   (list new-initial-energy new-current-energy))
                 (let ((new-current-energy (- current-energy actual-cost)))
                   (list current-initial-energy new-current-energy))))
           '(0 0)
           sorted-tasks))

  (first result))