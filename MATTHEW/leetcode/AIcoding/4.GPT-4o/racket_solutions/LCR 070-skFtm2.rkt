(define (singleNonDuplicate nums)
  (foldl (lambda (x acc)
            (if (equal? x acc)
                (if (null? (cdr nums))
                    acc
                    (car (cdr nums)))
                x))
          #f
          nums))

(singleNonDuplicate '(1 1 2 2 3 3 4 4 8 8 9))