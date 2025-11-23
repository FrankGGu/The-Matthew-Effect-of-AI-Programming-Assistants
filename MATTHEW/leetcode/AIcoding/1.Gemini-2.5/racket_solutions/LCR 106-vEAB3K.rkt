#lang racket

(require racket/queue)

(define (is-bipartite graph)
  (define n (length graph))
  (define colors (make-vector n -1)) ; -1: uncolored, 0: color A, 1: color B

  (call-with-current-continuation
   (lambda (return)
     (for ([i (in-range n)])
       (when (= (vector-ref colors i) -1)
         (define q (make-queue))
         (queue-put! q i)
         (vector-set! colors i 0)

         (let bfs-loop ()
           (unless (queue-empty? q)
             (define u (queue-get! q))
             (define u-color (vector-ref colors u))

             (for ([v (list-ref graph u)])
               (cond
                 [(= (vector-ref colors v) -1)
                  (vector-set! colors v (- 1 u-color))
                  (queue-put! q v)]
                 [(= (vector-ref colors v) u-color)
                  (return #f)]
                 [else
                  #f]))
             (bfs-loop)))))
     #t)))