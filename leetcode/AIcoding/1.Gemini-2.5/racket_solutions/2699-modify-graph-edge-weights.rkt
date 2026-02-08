#lang racket

(require racket/heap) ; For priority queue

(define +infinity (expt 10 18)) ; A sufficiently large number for infinity

(define (dijkstra n graph source destination current-edges)
  (define dist (make-vector n +infinity))
  (vector-set! dist source 0)

  ; Priority queue stores (distance . node)
  ; Min-heap based on distance
  (define pq (make-heap (lambda (a b) (< (car a) (car b)))))
  (heap-add! pq (cons 0 source))

  (let loop ()
    (when (not (heap-empty? pq))
      (define-values (current-d u) (heap-remove-top! pq))

      ; If we've already found a shorter path to u, skip this one
      (when (> current-d (vector-ref dist u))
        (loop))

      ; Explore neighbors of u
      (for ([edge-info (vector-ref graph u)])
        (define v (car edge-info)) ; Neighbor node
        (define original-idx (cadr edge-info)) ; Original index in 'edges' array
        (define weight (list-ref (list-ref current-edges original-idx) 2)) ; Current weight from modified-edges

        ; Only consider valid edges (weight must be positive and not -1)
        ; The `current-edges` should not have -1 weights at this stage, but defensive check
        (when (and (not (= weight -1))
                   (< (+ (vector-ref dist u) weight) (vector-ref dist v)))
          (vector-set! dist v (+ (vector-ref dist u) weight))
          (heap-add! pq (cons (vector-ref dist v) v))))
      (loop)))
  (vector-ref dist destination)) ; Return shortest distance to destination

(define (modify-graph-edge-weights n edges source destination target)
  (define num-edges (length edges))
  ; Create a deep copy of edges to modify
  (define modified-edges (map (lambda (e) (list (car e) (cadr e) (caddr e))) edges))

  ; Build adjacency list for Dijkstra.
  ; graph[u] stores a list of (v, original_idx).
  ; The actual weight used in Dijkstra will be fetched from `current-edges` using `original_idx`.
  (define graph (make-vector n (list)))
  (for ([i (in-range num-edges)])
    (define edge (list-ref edges i))
    (define u (car edge))
    (define v (cadr edge))
    ; Store original_idx to access current weight from modified-edges
    (vector-set! (vector-ref graph u) (cons (list v i) (vector-ref graph u)))
    (vector-set! (vector-ref graph v) (cons (list u i) (vector-ref graph v))))

  ; --- Phase 1: Calculate shortest path with all -1 edges set to 1 ---
  (for ([i (in-range num-edges)])
    (when (= (list-ref (list-ref modified-edges i) 2) -1)
      (list-set! (list-ref modified-edges i) 2 1))) ; Set -1 weights to 1

  (define dist-min (dijkstra n graph source destination modified-edges))

  (cond
    ; Case 1: Shortest path with min weights is already too long
    ((> dist-min target)
     ; Return a new deep copy of the original edges as specified
     (map (lambda (e) (list (car e) (cadr e) (caddr e))) edges))

    ; Case 2: Shortest path with min weights is exactly target
    ((= dist-min target)
     ; Return the modified edges (with -1s set to 1)
     modified-edges)

    ; --- Phase 3: Increase path length if dist-min < target ---
    (else ; dist-min < target
     ; We need to increase the total path length by `diff`
     (define diff (- target dist-min))

     ; Distribute the `diff` among the original -1 edges
     (for ([i (in-range num-edges)])
       (when (= (caddr (list-ref edges i)) -1) ; Check if original edge was -1
         (when (> diff 0)
           (define current-weight (list-ref (list-ref modified-edges i) 2)) ; Should be 1
           ; Increase amount is min of remaining diff and (target - current-weight)
           ; (target - current-weight) ensures edge weight doesn't exceed target,
           ; which would make it unlikely to be on a shortest path of length target.
           (define increase-amount (min diff (- target current-weight)))
           (list-set! (list-ref modified-edges i) 2 (+ current-weight increase-amount))
           (set! diff (- diff increase-amount)))
         ; If diff is 0 or less, ensure remaining original -1 edges are set to 1
         ; (They are already 1 from Phase 1, this is for clarity/robustness)
         (unless (> diff 0)
           (list-set! (list-ref modified-edges i) 2 1))))

     ; --- Phase 4: Calculate shortest path with new modified weights ---
     (define dist-final (dijkstra n graph source destination modified-edges))

     ; Case 3: Check if the final shortest path is exactly target
     (if (= dist-final target)
         modified-edges
         ; Case 4: Impossible to achieve target with this strategy
         (map (lambda (e) (list (car e) (cadr e) (caddr e))) edges))))