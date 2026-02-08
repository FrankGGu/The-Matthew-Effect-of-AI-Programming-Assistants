(require data/queue)

(define (gcd a b)
  (if (= b 0)
      a
      (gcd b (remainder a b))))

(define (bfs start-node adj component-nodes-set)
  (let* ([q (make-queue)]
         [distances (make-hash)] ; node -> distance for this specific BFS
         [farthest-node start-node]
         [max-dist 0])

    (queue-enqueue! q (list start-node 0))
    (hash-set! distances start-node 0)

    (let loop ()
      (when (not (queue-empty? q))
        (let* ([curr-pair (queue-dequeue! q)]
               [curr-node (car curr-pair)]
               [curr-dist (cadr curr-pair)])

          (when (> curr-dist max-dist)
            (set! max-dist curr-dist)
            (set! farthest-node curr-node))

          (for ([neighbor (hash-ref adj curr-node '())])
            (when (and (hash-has-key? component-nodes-set neighbor)
                       (not (hash-has-key? distances neighbor)))
              (hash-set! distances neighbor (+ curr-dist 1))
              (queue-enqueue! q (list neighbor (+ curr-dist 1)))))
          (loop))))
    (list farthest-node max-dist)))

(define (longest-special-path n edges)
  (define adj (make-hash))
  (for ([i (range 1 (+ n 1))])
    (hash-set! adj i '()))

  (for ([edge edges])
    (let ([u (car edge)]
          [v (cadr edge)])
      (when (> (gcd u v) 1)
        (hash-set! adj u (cons v (hash-ref adj u '())))
        (hash-set! adj v (cons u (hash-ref adj v '()))))))

  (define visited (make-hash))
  (define max-path-length 0)

  (for ([i (range 1 (+ n 1))])
    (when (not (hash-has-key? visited i))
      (let* ([component-nodes-set (make-hash)]
             [q-component (make-queue)])

        (queue-enqueue! q-component i)
        (hash-set! visited i #t)
        (hash-set! component-nodes-set i #t)

        (let component-bfs-loop ()
          (when (not (queue-empty? q-component))
            (let* ([curr-node (queue-dequeue! q-component)])
              (for ([neighbor (hash-ref adj curr-node '())])
                (when (not (hash-has-key? visited neighbor))
                  (hash-set! visited neighbor #t)
                  (hash-set! component-nodes-set neighbor #t)
                  (queue-enqueue! q-component neighbor))))
            (component-bfs-loop))))

        (when (> (hash-count component-nodes-set) 1)
          (let* ([start-node (car (hash-keys component-nodes-set))]
                 [bfs1-result (bfs start-node adj component-nodes-set)]
                 [u (car bfs1-result)]
                 [bfs2-result (bfs u adj component-nodes-set)]
                 [diameter (cadr bfs2-result)])
            (set! max-path-length (max max-path-length diameter)))))))

  max-path-length)