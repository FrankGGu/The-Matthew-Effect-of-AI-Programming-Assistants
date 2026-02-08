(define (find-students-who-improved grades)
  (define (helper grades result)
    (cond
      [(null? grades) result]
      [else
       (let* ([current-grade (car grades)]
              [student-id (hash-ref current-grade 'student_id)]
              [exam1-score (hash-ref current-grade 'exam1_score)]
              [exam2-score (hash-ref current-grade 'exam2_score)])
         (if (> exam2-score exam1-score)
             (helper (cdr grades) (cons student-id result))
             (helper (cdr grades) result)))]))
  (sort (helper grades '()) <))