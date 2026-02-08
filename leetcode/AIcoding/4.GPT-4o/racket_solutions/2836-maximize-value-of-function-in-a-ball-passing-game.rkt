(define (maxValueOfFunction passes)
  (define (dp i j)
    (if (>= i (length passes)) 0
        (if (>= j (length passes)) 0
            (max (dp (+ i 1) j) (dp (+ i 1) (+ j 1)) (+ (list-ref passes i) (list-ref passes j)))))
  (dp 0 0))