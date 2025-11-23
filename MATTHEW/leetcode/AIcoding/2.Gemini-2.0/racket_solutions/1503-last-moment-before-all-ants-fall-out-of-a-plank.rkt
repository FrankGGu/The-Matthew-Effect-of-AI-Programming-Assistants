(define (get-last-moment n left right)
  (max (apply max (map abs left))
       (apply max (map (lambda (x) (- n x)) right))
       0))