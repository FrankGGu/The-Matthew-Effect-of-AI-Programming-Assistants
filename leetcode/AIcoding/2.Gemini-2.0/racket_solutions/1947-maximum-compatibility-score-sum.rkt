(define (max-compatibility-sum students mentors)
  (define n (length students))
  (define (calculate-score student mentor)
    (let loop ([s student] [m mentor] [score 0])
      (if (null? s)
          score
          (if (equal? (car s) (car m))
              (loop (cdr s) (cdr m) (+ score 1))
              (loop (cdr s) (cdr m) score)))))
  (define (solve remaining-students remaining-mentors current-score)
    (if (null? remaining-students)
        current-score
        (apply max
               (map (lambda (mentor)
                      (solve (cdr remaining-students)
                             (remove mentor remaining-mentors)
                             (+ current-score (calculate-score (car remaining-students) mentor))))
                    remaining-mentors))))
  (solve students mentors 0))