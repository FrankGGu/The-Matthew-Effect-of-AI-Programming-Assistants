(define (min-moves-to-seat seats students)
  (let* ((sorted-seats (sort seats <))
         (sorted-students (sort students <)))
    (apply + (map (lambda (seat student)
                    (abs (- seat student)))
                  sorted-seats
                  sorted-students))))