(define (expectNumber p)
  (let loop ((p p) (result 0))
    (if (null? p)
        result
        (let* ((x (car p))
               (next-p (cdr p)))
          (loop next-p (+ result (/ 1 x)))))))

(define (solve nums)
  (expectNumber nums))