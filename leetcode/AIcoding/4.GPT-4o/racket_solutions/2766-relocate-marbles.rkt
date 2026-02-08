(define (relocateMarbles start move)
  (let ((positions (set (append start move))))
    (sort (set->list positions) <)))