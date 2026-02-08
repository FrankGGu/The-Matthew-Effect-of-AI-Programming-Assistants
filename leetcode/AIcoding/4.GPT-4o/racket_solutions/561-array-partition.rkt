(define (array-partition nums)
  (define sorted-nums (sort nums <))
  (define (pair-sum lst)
    (if (null? lst)
        0
        (+ (car lst) (pair-sum (cddr lst)))))
  (pair-sum sorted-nums))

(array-partition '(1 4 3 2))