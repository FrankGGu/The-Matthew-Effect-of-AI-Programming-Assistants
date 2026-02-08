(define (validate-binary-tree-nodes n left-child right-child)
  (define in-degree (make-vector n 0))
  (for ([i (in-range n)])
    (when (not (= (vector-ref left-child i) -1))
      (vector-set! in-degree (vector-ref left-child i) (+ (vector-ref in-degree (vector-ref left-child i)) 1)))
    (when (not (= (vector-ref right-child i) -1))
      (vector-set! in-degree (vector-ref right-child i) (+ (vector-ref in-degree (vector-ref right-child i)) 1))))
  (define roots (filter (lambda (i) (= (vector-ref in-degree i) 0)) (in-range n)))
  (if (not (= (length roots) 1))
      #f
      (let ([root (car roots)])
        (define visited (make-vector n #f))
        (define queue (list root))
        (define count 0)
        (define (bfs)
          (cond
            [(empty? queue) #t]
            [else
             (let* ([node (car queue)]
                    [new-queue (cdr queue)])
               (if (vector-ref visited node)
                   #f
                   (begin
                     (vector-set! visited node #t)
                     (set! count (+ count 1))
                     (let ([l (vector-ref left-child node)]
                           [r (vector-ref right-child node)])
                       (if (not (= l -1))
                           (set! new-queue (append new-queue (list l))))
                       (if (not (= r -1))
                           (set! new-queue (append new-queue (list r)))))
                     (set! queue new-queue)
                     (bfs))))]))
        (and (bfs) (= count n)))))