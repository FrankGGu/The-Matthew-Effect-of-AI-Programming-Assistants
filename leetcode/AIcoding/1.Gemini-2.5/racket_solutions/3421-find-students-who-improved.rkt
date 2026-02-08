(define (find-students-who-improved students)
  (let* ((improved-students
          (filter (lambda (student)
                    (let ((before-score (cadr student))
                          (after-score (caddr student)))
                      (> after-score before-score)))
                  students))
         (improved-ids
          (map car improved-students)))
    (sort improved-ids <)))