(define (minMovesToSeat seats students)
  (define sorted-seats (sort seats <))
  (define sorted-students (sort students <))
  (define (calculate-moves s1 s2)
    (if (null? s1)
        0
        (+ (abs (- (car s1) (car s2)))
           (calculate-moves (cdr s1) (cdr s2)))))
  (calculate-moves sorted-seats sorted-students))