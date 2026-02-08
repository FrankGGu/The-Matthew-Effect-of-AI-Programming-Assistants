(define (final-value-after-operations operations)
  (foldl (lambda (op acc)
           (cond
             [(string=? op "++X") (+ acc 1)]
             [(string=? op "X++") (+ acc 1)]
             [(string=? op "--X") (- acc 1)]
             [(string=? op "X--") (- acc 1)]
             [else acc]))
         0
         operations))