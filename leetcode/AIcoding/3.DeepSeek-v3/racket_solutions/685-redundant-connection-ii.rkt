#lang racket

(define (find-redundant-directed-connection edges)
  (define n (length edges))
  (define parent (make-vector (+ n 1) 0))
  (define candidate1 #f)
  (define candidate2 #f)

  (for ([edge edges])
    (define u (first edge))
    (define v (second edge))
    (if (zero? (vector-ref parent v))
        (vector-set! parent v u)
        (begin
          (set! candidate1 (list (vector-ref parent v) v))
          (set! candidate2 edge)
          (vector-set! parent v -1))))

  (for ([i (in-range (+ n 1))])
    (vector-set! parent i i))

  (define (find u)
    (if (not (= u (vector-ref parent u)))
        (begin
          (vector-set! parent u (find (vector-ref parent u)))
          (vector-ref parent u))
        u))

  (for ([edge edges])
    (define u (first edge))
    (define v (second edge))
    (if (equal? edge candidate2)
        (void)
        (let ([root-u (find u)]
              [root-v (find v)])
          (if (= root-u root-v)
              (if candidate1
                  candidate1
                  edge)
              (vector-set! parent root-v root-u)))))

  (if (and candidate1 (not (find (first candidate1))))
      candidate1
      candidate2))