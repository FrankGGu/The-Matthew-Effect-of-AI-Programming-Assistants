#lang racket

(define (count-rectangles rectangles points)
  (define (compare p1 p2)
    (cond
      [(< (car p1) (car p2)) #t]
      [(> (car p1) (car p2)) #f]
      [else (<= (cadr p1) (cadr p2))]))

  (define (sort-points points)
    (sort points compare))

  (define (find-count x y sorted-points)
    (define (helper i count)
      (if (>= i (length sorted-points))
          count
          (let ([p (list-ref sorted-points i)])
            (if (and (>= (car p) x) (>= (cadr p) y))
                (helper (+ i 1) (+ count 1))
                (helper (+ i 1) count)))))
    (helper 0 0))

  (define sorted-points (sort-points points))
  (map (lambda (p) (find-count (car p) (cadr p) sorted-points)) points))