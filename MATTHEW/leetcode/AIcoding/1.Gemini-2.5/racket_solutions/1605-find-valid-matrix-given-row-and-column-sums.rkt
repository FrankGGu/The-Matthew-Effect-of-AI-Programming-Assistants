#lang racket

(define (restore-matrix rowSum colSum)
  (define m (length rowSum))
  (define n (length colSum))

  (define current-row-sums (list->vector rowSum))
  (define current-col-sums (list->vector colSum))

  (define grid (build-vector m (lambda (i) (build-vector n (lambda (j) 0)))))

  (for ([i (in-range m)])
    (for ([j (in-range n)])
      (define r-sum (vector-ref current-row-sums i))
      (define c-sum (vector-ref current-col-sums j))
      (define val (min r-sum c-sum))

      (vector-set! (vector-ref grid i) j val)
      (vector-set! current-row-sums i (- r-sum val))
      (vector-set! current-col-sums j (- c-sum val))))

  (for/list ([row-vec grid])
    (vector->list row-vec)))