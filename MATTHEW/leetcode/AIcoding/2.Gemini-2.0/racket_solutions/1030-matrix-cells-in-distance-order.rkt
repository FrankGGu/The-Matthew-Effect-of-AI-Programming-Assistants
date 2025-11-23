(define (all-cells-dist-order rows cols r-center c-center)
  (define cells (for*/list ([i (in-range rows)]
                            [j (in-range cols)])
                  (list i j)))
  (sort cells (lambda (c1 c2)
                 (< (+ (abs (- (first c1) r-center)) (abs (- (second c1) c-center)))
                    (+ (abs (- (first c2) r-center)) (abs (- (second c2) c-center)))))))