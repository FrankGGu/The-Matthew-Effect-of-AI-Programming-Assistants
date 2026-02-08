(define (find-complement num)
  (let* ((bits (integer-length num))
         (mask (- (expt 2 bits) 1)))
    (- mask num)))