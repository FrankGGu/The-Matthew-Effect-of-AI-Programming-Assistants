(define (minOperations boxes)
  (define n (string-length boxes))
  (define (operations-to-box i)
    (apply + (map (lambda (j) (abs (- j i))) (for/list ((k n)) k))))
  (for/list ((i n)) (operations-to-box i)))

(minOperations "110") ; Example usage