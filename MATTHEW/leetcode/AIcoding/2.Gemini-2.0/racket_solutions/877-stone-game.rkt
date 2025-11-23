(define (stone-game piles)
  (define (solve l r)
    (cond
      [(>= l r) 0]
      [else
       (max (- (list-ref piles l) (solve (+ l 1) r))
            (- (list-ref piles r) (solve l (- r 1))))]))
  (> (solve 0 (- (length piles) 1)) 0))