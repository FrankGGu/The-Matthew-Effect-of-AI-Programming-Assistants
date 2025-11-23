(define (sort-by-distance rows cols r0 c0)
  (define (distance r c)
    (+ (abs (- r r0)) (abs (- c c0))))
  (define cells
    (for*/list ([r (in-range rows)]
                [c (in-range cols)])
      (list r c)))
  (sort cells (lambda (a b) (< (distance (car a) (cadr a)) (distance (car b) (cadr b))))))