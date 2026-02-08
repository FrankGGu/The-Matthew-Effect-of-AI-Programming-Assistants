(define (countStudents students sandwiches)
  (define (helper students sandwiches count)
    (if (null? sandwiches)
        count
        (let ((current-sandwich (car sandwiches)))
          (let loop ((remaining students) (found #f))
            (cond
              ((null? remaining) (if found (helper students (cdr sandwiches) count) count))
              ((equal? (car remaining) current-sandwich)
               (loop (cdr remaining) #t))
              (else
               (loop (cdr remaining) found))))))
  (helper students sandwiches (length students)))

(define (main)
  (countStudents (list 1 1 0 0) (list 0 1 0 1)))

(main)