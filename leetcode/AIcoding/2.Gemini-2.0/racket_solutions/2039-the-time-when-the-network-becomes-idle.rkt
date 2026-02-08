(define (network-becomes-idle times patience)
  (let* ([n (vector-length times)]
         [dist (make-vector n #f)]
         [q (queue)]
         [adj (make-vector n '()))
         (build-adj
          (for/list ([i (in-range 1 n)])
            (set! adj (vector-set! adj 0 (cons i (vector-ref adj 0))))
            (set! adj (vector-set! adj i (cons 0 (vector-ref adj i))))))
         (bfs
          (let loop ([node 0] [d 0])
            (vector-set! dist node d)
            (for ([neighbor (in-list (vector-ref adj node))])
              (when (not (vector-ref dist neighbor))
                (enqueue! q neighbor)
                (vector-set! dist neighbor (+ d 1))))
            (if (queue-empty? q)
                #t
                (loop (dequeue! q) (+ d 1)))))
         (max-time
          (for/fold ([max-t 0]) ([i (in-range 1 n)])
            (let* ([travel-time (* 2 (vector-ref dist i))]
                   [last-sent (quotient (- travel-time 1) (vector-ref patience i))]
                   [retransmit-time (* last-sent (vector-ref patience i))]
                   [idle-time (+ travel-time retransmit-time)])
              (max max-t idle-time)))))
    (begin
      (vector-set! dist 0 0)
      (enqueue! q 0)
      (bfs 0 0)
      (+ max-time 1))))