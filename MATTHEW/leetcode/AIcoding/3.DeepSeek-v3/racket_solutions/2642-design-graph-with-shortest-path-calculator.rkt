(define graph%
  (class object%
    (super-new)
    (init-field n edges)
    (field [adj (make-vector n '())])

    (for ([edge edges])
      (let ([from (vector-ref edge 0)]
            [to (vector-ref edge 1)]
            [cost (vector-ref edge 2)])
        (vector-set! adj from (cons (cons to cost) (vector-ref adj from)))))

    (define/public (addEdge edge)
      (let ([from (vector-ref edge 0)]
            [to (vector-ref edge 1)]
            [cost (vector-ref edge 2)])
        (vector-set! adj from (cons (cons to cost) (vector-ref adj from)))))

    (define/public (shortestPath node1 node2)
      (let ([heap (make-heap (lambda (a b) (< (car a) (car b)))]
            [dist (make-vector n +inf.0)])
        (vector-set! dist node1 0)
        (heap-add! heap (cons 0 node1))
        (let loop ()
          (if (zero? (heap-count heap))
              (if (= (vector-ref dist node2) +inf.0) -1 (inexact->exact (vector-ref dist node2)))
              (let* ([current (heap-remove! heap)]
                     [current-dist (car current)]
                     [current-node (cdr current)])
                (when (<= current-dist (vector-ref dist current-node))
                  (for ([neighbor (vector-ref adj current-node)])
                    (let ([next-node (car neighbor)]
                          [next-cost (cdr neighbor)])
                      (when (< (+ current-dist next-cost) (vector-ref dist next-node))
                        (vector-set! dist next-node (+ current-dist next-cost))
                        (heap-add! heap (cons (vector-ref dist next-node) next-node))))))
                (loop)))))))