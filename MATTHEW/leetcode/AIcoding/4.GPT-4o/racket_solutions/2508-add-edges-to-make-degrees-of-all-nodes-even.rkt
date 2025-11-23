(define (addEdgesToMakeDegreesEven n edges)
  (define degrees (make-vector n 0))
  (for ([edge edges])
    (vector-set! degrees (car edge) (+ 1 (vector-ref degrees (car edge))))
    (vector-set! degrees (cadr edge) (+ 1 (vector-ref degrees (cadr edge)))))

  (define odd-nodes (filter (lambda (i) (odd? (vector-ref degrees i))) (range n)))
  (define odd-count (length odd-nodes))

  (if (even? odd-count)
      (map (lambda (i j) (list (vector-ref odd-nodes i) (vector-ref odd-nodes j)))
           (range (/ odd-count 2))
           (range (/ odd-count 2)))
      '()))

(define (addEdges n edges)
  (addEdgesToMakeDegreesEven n edges))