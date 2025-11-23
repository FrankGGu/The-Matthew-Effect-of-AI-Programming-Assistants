(define (comfortable-humidity ranges)
  (define (merge-ranges ranges)
    (cond [(empty? ranges) '()]
          [(empty? (cdr ranges)) ranges]
          [else
           (let ([r1 (car ranges)]
                 [r2 (car (cdr ranges))])
             (if (<= (car r2) (cadr r1))
                 (merge-ranges (cons (list (min (car r1) (car r2)) (max (cadr r1) (cadr r2))) (cddr ranges)))
                 (cons r1 (merge-ranges (cdr ranges)))))]))

  (define (count-days ranges)
    (foldl + 0 (map (lambda (range) (- (cadr range) (car range) 0)) ranges)))

  (count-days (merge-ranges (sort ranges (lambda (r1 r2) (< (car r1) (car r2))))))
  )