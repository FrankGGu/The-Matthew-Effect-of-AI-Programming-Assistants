(define (canVisitAllRooms rooms)
  (let* ([n (length rooms)]
         [visited (make-vector n #f)]
         [q (queue)]
         (void (queue-enqueue! q 0))
         (vector-set! visited 0 #t))
    (let loop ()
      (if (queue-empty? q)
          (for/and ([i (in-range n)])
            (vector-ref visited i))
          (let ([room-index (queue-dequeue! q)])
            (for ([key (in-list (vector-ref rooms room-index))])
              (when (not (vector-ref visited key))
                (vector-set! visited key #t)
                (queue-enqueue! q key)))
            (loop))))))