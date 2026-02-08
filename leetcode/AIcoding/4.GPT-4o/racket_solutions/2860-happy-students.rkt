(define (happyStudents students)
  (define (count-happy lst)
    (foldl (lambda (x acc)
              (if (and (>= x 4) (<= x 6))
                  (+ acc 1)
                  acc))
            0
            lst))
  (count-happy students))