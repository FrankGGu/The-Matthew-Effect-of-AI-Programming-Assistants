(define/contract (possible-bipartition n dislikes)
  (-> exact-integer? (listof (listof exact-integer?)) boolean?)
  (define graph (make-vector n '()))
  (for ([pair dislikes])
    (let ([u (sub1 (first pair))]
          [v (sub1 (second pair))])
      (vector-set! graph u (cons v (vector-ref graph u)))
      (vector-set! graph v (cons u (vector-ref graph v)))))

  (define color (make-vector n -1))

  (define (bfs start)
    (let ([q (make-queue)])
      (enqueue! q start)
      (vector-set! color start 0)
      (let loop ()
        (unless (queue-empty? q)
          (let ([u (dequeue! q)])
            (for ([v (vector-ref graph u)])
              (cond
                [(= (vector-ref color v) -1)
                 (vector-set! color v (- 1 (vector-ref color u)))
                 (enqueue! q v)]
                [(= (vector-ref color v) (vector-ref color u))
                 #f]))
            (loop)))))
    #t)

  (for ([i (in-range n)])
    (when (= (vector-ref color i) -1)
      (unless (bfs i)
        (return #f))))
  #t)