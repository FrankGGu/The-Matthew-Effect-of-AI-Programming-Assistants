(define (find-closest-number-to-zero nums)
  (let ((initial-closest (first nums)))
    (foldl (lambda (n current-closest)
             (let ((abs-n (abs n))
                   (abs-current-closest (abs current-closest)))
               (cond
                 ((< abs-n abs-current-closest) n)
                 ((= abs-n abs-current-closest) (max n current-closest))
                 (else current-closest))))
           initial-closest
           (rest nums))))