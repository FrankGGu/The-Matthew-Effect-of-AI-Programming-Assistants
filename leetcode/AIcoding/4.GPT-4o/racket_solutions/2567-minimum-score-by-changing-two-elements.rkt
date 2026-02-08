(define (min-score-change nums)
  (define (min-score arr)
    (if (null? arr)
        0
        (foldl min (car arr) (cdr arr))))
  (let* ((min1 (min-score nums))
         (sorted (sort nums <)))
    (if (>= (length nums) 2)
        (min (min1 (car sorted)) (min1 (cadr sorted)))
        min1)))

(min-score-change '(1 2 3 4 5))