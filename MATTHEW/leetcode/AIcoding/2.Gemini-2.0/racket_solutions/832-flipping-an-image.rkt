(define (flip-and-invert-image A)
  (map (lambda (row)
         (reverse (map (lambda (x) (if (= x 0) 1 0)) row))) A))