(define (longest-cycle edges)
  (define n (vector-length edges))
  (define state (make-vector n 0)) ; 0: unvisited, 1: visiting (on current path), 2: visited (fully processed)
  (define time-of-visit (make-vector n -1)) ; Stores distance from the start node of the current path
  (define max-cycle-len -1)

  (for ([i (in-range n)])
    (when (= (vector-ref state i) 0) ; If node i is unvisited
      (define current-node i)
      (define current-time 0)
      (define path-nodes-in-current-traversal '()) ; List to store nodes in the current path for marking as '2'

      (let loop ()
        (when (and (not (= current-node -1))
                   (= (vector-ref state current-node) 0)) ; If next node is unvisited
          (vector-set! state current-node 1) ; Mark as visiting
          (vector-set! time-of-visit current-node current-time) ; Record time/distance
          (set! path-nodes-in-current-traversal (cons current-node path-nodes-in-current-traversal))
          (set! current-node (vector-ref edges current-node))
          (set! current-time (+ current-time 1))
          (loop)))

      ; After the loop, current-node is either -1 (path ends),
      ; or its state is 1 (cycle detected), or its state is 2 (hit an already processed node).
      (when (and (not (= current-node -1))
                 (= (vector-ref state current-node) 1)) ; If we hit a node currently visiting (state 1)
        ; A cycle is detected. Calculate its length.
        (set! max-cycle-len (max max-cycle-len
                                 (- current-time (vector-ref time-of-visit current-node)))))

      ; Mark all nodes that were part of this specific traversal (marked 1) as fully visited (2).
      ; This prevents re-processing them in future outer loops.
      (for ([node path-nodes-in-current-traversal])
        (vector-set! state node 2))))

  max-cycle-len)