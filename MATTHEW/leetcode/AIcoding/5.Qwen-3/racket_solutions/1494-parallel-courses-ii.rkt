#lang racket

(define (parallel-courses n relations)
  (define in-degree (make-vector n 0))
  (define graph (make-vector n '()))
  (for-each
   (lambda (rel)
     (let ([u (car rel)]
           [v (cadr rel)])
       (vector-set! graph u (cons v (vector-ref graph u)))
       (vector-set! in-degree v (+ 1 (vector-ref in-degree v)))))
   relations)

  (define (topo-sort)
    (define q (queue))
    (for ([i (in-range n)])
      (when (= (vector-ref in-degree i) 0)
        (queue-add! q i)))

    (define result '())
    (define count 0)
    (define visited (make-vector n #f))

    (define (bfs)
      (when (not (queue-empty? q))
        (define u (queue-remove! q))
        (set! count (+ count 1))
        (set! result (cons u result))
        (for-each
         (lambda (v)
           (vector-set! in-degree v (- (vector-ref in-degree v) 1))
           (when (= (vector-ref in-degree v) 0)
             (queue-add! q v)))
         (vector-ref graph u))
        (bfs)))

    (bfs)
    (if (= count n)
        (reverse result)
        #f))

  (define topo (topo-sort))
  (if (not topo)
      -1
      (let ([dp (make-vector n 1)])
        (for-each
         (lambda (u)
           (for-each
            (lambda (v)
              (when (> (vector-ref dp v) (add1 (vector-ref dp u)))
                (vector-set! dp v (add1 (vector-ref dp u)))))
            (vector-ref graph u)))
         topo)
        (apply max (vector->list dp)))))