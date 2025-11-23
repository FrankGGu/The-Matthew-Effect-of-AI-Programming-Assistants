(define (final-value-after-operations operations)
  (foldl (lambda (op acc)
           (cond
             [(or (string=? op "++X") (string=? op "X++")) (+ acc 1)]
             [(or (string=? op "--X") (string=? op "X--")) (- acc 1)]
             [else acc])) ; Should not be reached given problem constraints
         0
         operations))