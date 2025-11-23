(define (isBipartite graph)
  (define color (make-vector (vector-length graph) -1))

  (define (bfs start)
    (define queue (list start))
    (vector-set! color start 0)

    (let loop ()
      (if (null? queue)
          #t
          (let* ((node (car queue))
                 (new-queue (cdr queue))
                 (current-color (vector-ref color node))
                 (next-color (if (= current-color 0) 1 0))
                 (neighbors (vector-ref graph node)))
            (for-each (lambda (neighbor)
                        (cond
                          ((= (vector-ref color neighbor) -1)
                           (vector-set! color neighbor next-color)
                           (set! new-queue (append new-queue (list neighbor))))
                          ((= (vector-ref color neighbor) current-color)
                           (set! new-queue '())))
                        )
                      neighbors)
            (set! queue new-queue)
            (loop)))))

  (for ((i (in-range (vector-length graph))))
    (when (= (vector-ref color i) -1)
      (if (not (bfs i))
          (return #f))))

  #t)