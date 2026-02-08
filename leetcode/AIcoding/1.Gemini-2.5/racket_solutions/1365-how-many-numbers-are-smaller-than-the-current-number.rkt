(define (smaller-numbers nums)
  (map (lambda (x)
         (count (lambda (y) (< y x)) nums))
       nums))