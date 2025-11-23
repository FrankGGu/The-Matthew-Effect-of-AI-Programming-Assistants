(define (robot s)
  (string-foldl
   (lambda (char current-x)
     (case char
       ((#\A) (+ (* 2 current-x) 1))
       ((#\B) (+ (* 2 current-x) 2))))
   0
   s))