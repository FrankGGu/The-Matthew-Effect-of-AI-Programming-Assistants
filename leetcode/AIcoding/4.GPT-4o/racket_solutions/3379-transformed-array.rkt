(define (transformedArray(arr))
  (map (lambda (x) (if (<= x 0) 0 (* x x))) arr))