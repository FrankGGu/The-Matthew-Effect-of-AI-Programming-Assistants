(define (num-moves-stones a b c)
  (define sorted-stones (sort (list a b c) <))
  (define x (list-ref sorted-stones 0))
  (define y (list-ref sorted-stones 1))
  (define z (list-ref sorted-stones 2))
  (define min-moves
    (cond
      [(and (= (- y x) 1) (= (- z y) 1)) 0]
      [(or (= (- y x) 1) (= (- z y) 1) (= (- y x) 2) (= (- z y) 2)) 1]
      [else 2]))
  (define max-moves (- (- z x) 2))
  (list min-moves max-moves))