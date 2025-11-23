(define (min-moves seats students)
  (let* ((sorted-seats (sort seats <))
         (sorted-students (sort students <)))
    (apply + (map (lambda (s t) (abs (- s t))) sorted-seats sorted-students))))