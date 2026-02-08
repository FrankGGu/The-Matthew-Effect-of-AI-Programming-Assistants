(define (node-with-highest-edge-score edges)
  (define n (length edges))
  (define scores (make-vector n 0))

  (for ([u (in-range n)])
    (define v (list-ref edges u))
    (vector-set! scores v (+ (vector-ref scores v) u)))

  (define max-score (vector-ref scores 0))
  (define best-node 0)

  (for ([i (in-range 1 n)])
    (define current-score (vector-ref scores i))
    (when (> current-score max-score)
      (set! max-score current-score)
      (set! best-node i)))

  best-node)