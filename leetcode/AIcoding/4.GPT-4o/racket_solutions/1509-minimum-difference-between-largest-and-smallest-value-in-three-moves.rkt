(define (min-diff nums)
  (define sorted (sort nums <))
  (define n (length sorted))
  (if (<= n 4)
      0
      (min
       (- (list-ref sorted (- n 1)) (list-ref sorted 3))
       (- (list-ref sorted (- n 2)) (list-ref sorted 2))
       (- (list-ref sorted (- n 3)) (list-ref sorted 1))
       (- (list-ref sorted (- n 4)) (list-ref sorted 0)))))

(min-diff '(1 5 0 10 14))