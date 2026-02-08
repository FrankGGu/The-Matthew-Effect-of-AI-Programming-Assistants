(define (smaller-numbers-than-current nums)
  (map (lambda (n)
         (length (filter (lambda (x) (< x n)) nums)))
       nums))