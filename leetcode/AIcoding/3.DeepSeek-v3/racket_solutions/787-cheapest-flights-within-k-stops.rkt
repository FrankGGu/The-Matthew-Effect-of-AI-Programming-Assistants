(define/contract (find-cheapest-price n flights src dst k)
  (-> exact-integer? (listof (listof exact-integer?)) exact-integer? exact-integer? exact-integer?)
  (define graph (make-hash))
  (for ([flight flights])
    (let ([from (first flight)]
          [to (second flight)]
          [price (third flight)])
      (hash-update! graph from (lambda (lst) (cons (list to price) lst)) '())))

  (define prices (make-vector n +inf.0))
  (vector-set! prices src 0)

  (define queue (make-queue))
  (enqueue! queue (list src 0 0))

  (let loop ()
    (if (queue-empty? queue)
        (let ([result (vector-ref prices dst)])
          (if (= result +inf.0) -1 result))
        (let* ([current (dequeue! queue)]
               [node (first current)]
               [cost (second current)]
               [stops (third current)])
          (if (> stops k)
              (loop)
              (begin
                (for ([neighbor (hash-ref graph node '())])
                  (let ([next-node (first neighbor)]
                        [next-cost (second neighbor)])
                    (let ([new-cost (+ cost next-cost)])
                      (if (< new-cost (vector-ref prices next-node))
                          (begin
                            (vector-set! prices next-node new-cost)
                            (enqueue! queue (list next-node new-cost (+ stops 1))))))))
                (loop))))))