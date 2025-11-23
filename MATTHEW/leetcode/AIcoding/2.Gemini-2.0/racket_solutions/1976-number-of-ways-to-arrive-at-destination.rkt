(define (count-paths n roads)
  (define graph (make-hash))
  (for ([road roads])
    (let ([u (car road)] [v (cadr road)] [w (caddr road)])
      (hash-update! graph u (lambda (xs) (cons (list v w) xs)) '())
      (hash-update! graph v (lambda (xs) (cons (list u w) xs)) '())))

  (define dist (make-vector (add1 n) +inf.0))
  (define ways (make-vector (add1 n) 0))
  (vector-set! dist 1 0)
  (vector-set! ways 1 1)

  (define pq (mutable-priority-queue <))
  (enqueue! pq (list 0 1))

  (define (dijkstra)
    (when (not (empty? pq))
      (let* ([curr (dequeue! pq)]
             [d (car curr)]
             [u (cadr curr)])
        (when (> d (vector-ref dist u))
          (dijkstra))
        (for ([neighbor (hash-ref graph u '())])
          (let* ([v (car neighbor)]
                 [w (cadr neighbor)]
                 [new-dist (+ d w)])
            (cond
              [(< new-dist (vector-ref dist v))
               (vector-set! dist v new-dist)
               (vector-set! ways v (vector-ref ways u))
               (enqueue! pq (list new-dist v))]
              [(= new-dist (vector-ref dist v))
               (vector-set! ways v (modulo (+ (vector-ref ways v) (vector-ref ways u)) 1000000007))]
              [else #f])))
        (dijkstra))))

  (dijkstra)
  (vector-ref ways n))