(define (min-cost-to-move-chips position)
  (let ([even-count (count (lambda (x) (even? x)) position)])
    (min even-count (- (length position) even-count))))