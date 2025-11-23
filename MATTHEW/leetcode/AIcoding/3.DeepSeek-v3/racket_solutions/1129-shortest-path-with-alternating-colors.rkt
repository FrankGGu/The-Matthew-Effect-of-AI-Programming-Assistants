#lang racket

(define (shortest-alternating-paths n red-edges blue-edges)
  (define red-graph (make-vector n '()))
  (define blue-graph (make-vector n '()))

  (for ([edge red-edges])
    (let ([from (car edge)]
          [to (cadr edge)])
      (vector-set! red-graph from (cons to (vector-ref red-graph from)))))

  (for ([edge blue-edges])
    (let ([from (car edge)]
          [to (cadr edge)])
      (vector-set! blue-graph from (cons to (vector-ref blue-graph from)))))

  (define dist (make-vector n (make-vector 2 +inf.0)))
  (vector-set! (vector-ref dist 0) 0 0)
  (vector-set! (vector-ref dist 0) 1 0)

  (define q (make-queue))
  (enqueue! q (list 0 0))
  (enqueue! q (list 0 1))

  (while (not (queue-empty? q))
    (let* ([node (dequeue! q)]
           [u (car node)]
           [color (cadr node)]
           [next-color (if (= color 0) 1 0)]
           [graph (if (= color 0) red-graph blue-graph)])
      (for ([v (vector-ref graph u)])
        (when (> (vector-ref (vector-ref dist v) next-color) (+ (vector-ref (vector-ref dist u) color) 1))
          (vector-set! (vector-ref dist v) next-color (+ (vector-ref (vector-ref dist u) color) 1))
          (enqueue! q (list v next-color))))))

  (define result (make-vector n -1))
  (for ([i (in-range n)])
    (let ([min-dist (min (vector-ref (vector-ref dist i) 0) (vector-ref (vector-ref dist i) 1))])
      (when (< min-dist +inf.0)
        (vector-set! result i min-dist))))
  (vector->list result))