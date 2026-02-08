#lang racket

(define (min-cost-walk graph start end)
  (define num-nodes (vector-length graph))
  (define costs (make-vector num-nodes +inf.0))
  (define visited (make-vector num-nodes #f))
  (vector-set! costs start 0)

  (define (dijkstra)
    (define (find-min-node)
      (define min-cost +inf.0)
      (define min-node -1)
      (for ([i (in-range num-nodes)])
        (when (and (not (vector-ref visited i)) (< (vector-ref costs i) min-cost))
          (set! min-cost (vector-ref costs i))
          (set! min-node i)))
      min-node)

    (define current-node (find-min-node))
    (when (not (= current-node -1))
      (set! visited (vector-set! visited current-node #t))
      (for ([neighbor (in-range (vector-length (vector-ref graph current-node)))])
        (when (and (not (vector-ref visited neighbor))
                   (> (vector-ref (vector-ref graph current-node) neighbor) 0))
          (define new-cost (+ (vector-ref costs current-node) (vector-ref (vector-ref graph current-node) neighbor)))
          (when (< new-cost (vector-ref costs neighbor))
            (vector-set! costs neighbor new-cost))))
      (dijkstra)))

  (dijkstra)
  (if (= (vector-ref costs end) +inf.0) -1 (vector-ref costs end)))

(define (minimumCost graph start end)
  (min-cost-walk graph start end))