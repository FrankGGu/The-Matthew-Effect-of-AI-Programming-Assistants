(define (find-the-city n edges distanceThreshold)
  (define INF (add1 (* n 10001))) ; A large enough number for infinity

  ; Initialize distance matrix
  (define dist (make-vector n))
  (for ([i (in-range n)])
    (vector-set! dist i (make-vector n INF)))

  ; Set diagonal to 0
  (for ([i (in-range n)])
    (vector-set! (vector-ref dist i) i 0))

  ; Populate with direct edge weights
  (for ([edge edges])
    (define u (car edge))
    (define v (cadr edge))
    (define w (caddr edge))
    (vector-set! (vector-ref dist u) v (min (vector-ref (vector-ref dist u) v) w))
    (vector-set! (vector-ref dist v) u (min (vector-ref (vector-ref dist v) u) w)))

  ; Floyd-Warshall algorithm
  (for ([k (in-range n)])
    (for ([i (in-range n)])
      (for ([j (in-range n)])
        (define current-dist (vector-ref (vector-ref dist i) j))
        (define path-through-k (+ (vector-ref (vector-ref dist i) k)
                                  (vector-ref (vector-ref dist k) j)))
        (when (< path-through-k current-dist)
          (vector-set! (vector-ref dist i) j path-through-k)))))

  ; Find the city with the smallest number of reachable neighbors
  (define min-neighbors (add1 n)) ; Initialize with a value greater than any possible count (n-1 is max)
  (define result-city -1)

  (for ([i (in-range n)])
    (define current-neighbors 0)
    (for ([j (in-range n)])
      (when (and (!= i j) (<= (vector-ref (vector-ref dist i) j) distanceThreshold))
        (set! current-neighbors (add1 current-neighbors))))

    ; Update result-city based on minimum neighbors and tie-breaking rule
    ; If current-neighbors is strictly less, it's a new minimum.
    ; If current-neighbors is equal, update to current city (which has a larger index due to iteration order).
    (when (<= current-neighbors min-neighbors)
      (set! min-neighbors current-neighbors)
      (set! result-city i)))

  result-city)