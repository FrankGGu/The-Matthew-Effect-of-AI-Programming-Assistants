#lang racket

(define (amount-of-time root target)
  (define (build-graph node parent graph)
    (when node
      (let ([val (car node)]
            [left (cadr node)]
            [right (caddr node)])
        (when parent
          (hash-set! graph val (cons parent (hash-ref graph val '())))
          (hash-set! graph parent (cons val (hash-ref graph parent '()))))
        (build-graph left val graph)
        (build-graph right val graph))))

  (define graph (make-hash))
  (build-graph root #f graph)

  (define (bfs start)
    (define q (queue (list start)))
    (define visited (set start))
    (define steps 0)
    (let loop ()
      (when (not (queue-empty? q))
        (define size (queue-length q))
        (for ([i (in-range size)])
          (define node (queue-dequeue q))
          (for ([neighbor (hash-ref graph node '())])
            (when (not (set-member? visited neighbor))
              (set-add! visited neighbor)
              (queue-enqueue q neighbor)))
        (when (> size 0)
          (set! steps (+ steps 1)))
        (loop))
      steps))

  (if (hash-has-key? graph target)
      (- (bfs target) 1)
      0))