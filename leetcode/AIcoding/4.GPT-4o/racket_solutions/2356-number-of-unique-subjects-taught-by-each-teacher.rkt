(define (numUniqueSubjects teacherSubjects)
  (map (lambda (subjects) (length (set (map (lambda (sub) sub) subjects)))) teacherSubjects))