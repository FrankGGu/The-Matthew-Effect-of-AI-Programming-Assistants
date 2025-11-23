(define (height-checker heights)
  (let ((sorted (sort heights <)))
    (for/sum ((h heights) (s sorted) #:when (not (= h s))) 1)))