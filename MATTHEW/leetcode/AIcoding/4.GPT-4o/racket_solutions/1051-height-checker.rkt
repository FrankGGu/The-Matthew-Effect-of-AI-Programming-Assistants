(define (heightChecker heights)
  (define sorted (sort heights <))
  (define (count-mismatches original sorted)
    (if (null? original)
        0
        (+ (if (equal? (car original) (car sorted)) 0 1)
           (count-mismatches (cdr original) (cdr sorted)))))
  (count-mismatches heights sorted))

(heightChecker '(1 1 4 2 1 3))