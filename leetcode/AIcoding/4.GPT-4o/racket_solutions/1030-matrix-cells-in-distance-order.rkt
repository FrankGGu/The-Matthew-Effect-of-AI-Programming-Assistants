(define (allCellsDistOrder rows cols r0 c0)
  (define (distance r c)
    (+ (abs (- r0 r)) (abs (- c0 c))))
  (define cells (for/list ([r (in-range rows)]
                           [c (in-range cols)])
                  (list r c (distance r c))))
  (define sorted-cells (sort cells (lambda (a b) (< (third a) (third b)))))
  (map (lambda (cell) (list (first cell) (second cell))) sorted-cells))