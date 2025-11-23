(define (shortest-alternating-paths n redEdges blueEdges)
  (define graph (make-vector n '()))
  (for ([edge redEdges])
    (let ([u (car edge)] [v (cadr edge)])
      (vector-set! graph u (cons (cons v 'red) (vector-ref graph u)))))
  (for ([edge blueEdges])
    (let ([u (car edge)] [v (cadr edge)])
      (vector-set! graph u (cons (cons v 'blue) (vector-ref graph u)))))

  (define (bfs)
    (define queue (make-queue))
    (define distances (make-vector n -1))
    (define visited (make-vector n #f))
    (enqueue! queue (list 0 'red))
    (enqueue! queue (list 0 'blue))
    (vector-set! distances 0 0)
    (vector-set! visited 0 #t)

    (let loop ()
      (if (queue-empty? queue)
          (vector->list distances)
          (let* ([current (dequeue! queue)]
                 ([node (car current)]
                  [color (cadr current)]
                  [next-color (if (eq? color 'red) 'blue 'red)])
                 [edges (vector-ref graph node)])
            (for ([edge edges])
              (let ([next-node (car edge)])
                (when (and (not (vector-ref visited next-node))
                           (eq? (cadr edge) next-color))
                  (vector-set! visited next-node #t)
                  (vector-set! distances next-node
                                (if (eq? (vector-ref distances next-node) -1)
                                    (+ (car current) 1)
                                    (min (vector-ref distances next-node) (+ (car current) 1))))
                  (enqueue! queue (list (car current) next-color)))))
            (loop)))))

  (bfs))