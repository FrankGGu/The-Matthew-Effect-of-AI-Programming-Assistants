(define (is-bipartite graph)
  (let* ([n (length graph)]
         [colors (make-vector n 0)] ; 0: uncolored, 1: color A, 2: color B
         [is-bipartite-result #t]) ; Flag to track if the graph is bipartite

    (for ([i (in-range n)]) ; Iterate through all nodes to handle disconnected components
      (when (and is-bipartite-result (= (vector-ref colors i) 0)) ; If node i is uncolored and still potentially bipartite
        (let ([q (list i)]) ; Initialize queue for this component
          (vector-set! colors i 1) ; Assign it color 1

          (let bfs-loop ([current-q q]) ; current-q is the state of the queue
            (when (and is-bipartite-result (not (empty? current-q)))
              (let* ([u (car current-q)]
                     [new-q (cdr current-q)] ; Dequeue u
                     [u-color (vector-ref colors u)])

                (for ([v (list-ref graph u)]) ; For each neighbor v of u
                  (when is-bipartite-result ; Only continue if still bipartite
                    (cond
                      [(= (vector-ref colors v) 0) ; If neighbor v is uncolored
                       (vector-set! colors v (if (= u-color 1) 2 1)) ; Assign opposite color
                       (set! new-q (append new-q (list v)))] ; Enqueue v
                      [(= (vector-ref colors v) u-color) ; If neighbor v has same color
                       (set! is-bipartite-result #f)] ; Set flag to false
                      [else ; Neighbor v has opposite color, consistent
                       #t])))) ; No action needed, continue

                (bfs-loop new-q))))))) ; Continue BFS loop with updated queue

    is-bipartite-result))