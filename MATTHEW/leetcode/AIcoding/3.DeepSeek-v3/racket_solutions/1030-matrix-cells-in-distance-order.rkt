(define/contract (all-cells-dist-order rows cols rCenter cCenter)
  (-> exact-integer? exact-integer? exact-integer? exact-integer? (listof (listof exact-integer?)))
  (let* ([cells (for*/list ([i (in-range rows)] [j (in-range cols)]) (list i j))]
         [distance (lambda (cell) (+ (abs (- (first cell) rCenter)) (abs (- (second cell) cCenter))))])
    (sort cells (lambda (a b) (< (distance a) (distance b))))))