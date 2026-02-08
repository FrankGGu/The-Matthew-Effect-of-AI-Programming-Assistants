(define (find-closest-node edges node1 node2)
  (define n (vector-length edges))

  ; Helper function to calculate distances from a start_node
  ; Returns a vector where dists[i] is the distance from start_node to i,
  ; or -1 if i is unreachable.
  (define (calculate-distances start-node)
    (define dists (make-vector n -1)) ; -1 indicates unreachable
    (define current-node start-node)
    (define distance 0)

    (let loop ()
      (when (and (not (= current-node -1))
                 (= (vector-ref dists current-node) -1)) ; Only visit unvisited nodes
        (vector-set! dists current-node distance)
        (set! current-node (vector-ref edges current-node))
        (set! distance (+ distance 1))
        (loop)))
    dists)

  (define dists1 (calculate-distances node1))
  (define dists2 (calculate-distances node2))

  (define min-max-dist (add1 n)) ; Initialize with a value larger than any possible distance
  (define result-node -1)

  (for ([k (in-range n)])
    (define d1 (vector-ref dists1 k))
    (define d2 (vector-ref dists2 k))

    (when (and (not (= d1 -1)) (not (= d2 -1))) ; If k is reachable from both node1 and node2
      (define current-max-dist (max d1 d2))
      (when (< current-max-dist min-max-dist)
        (set! min-max-dist current-max-dist)
        (set! result-node k))))

  result-node)