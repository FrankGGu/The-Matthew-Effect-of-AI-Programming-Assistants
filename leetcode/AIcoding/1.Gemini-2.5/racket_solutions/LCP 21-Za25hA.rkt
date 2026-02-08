#lang racket

(require racket/queue)

(define (bfs start n adj)
  (define dist (make-vector n -1)) ; Distance array, initialized to -1 (unvisited)
  (define q (make-queue))

  (vector-set! dist start 0)
  (enqueue! q start)

  (define farthest-node start)
  (define max-d 0) ; Max distance found so far during this BFS

  (let loop ()
    (when (not (queue-empty? q))
      (define u (dequeue! q))

      ; Update farthest node and max distance
      (when (> (vector-ref dist u) max-d)
        (set! max-d (vector-ref dist u))
        (set! farthest-node u))

      ; Explore neighbors
      (for ([v (vector-ref adj u)]) ; adj is a vector of lists
        (when (= (vector-ref dist v) -1) ; If neighbor v is unvisited
          (vector-set! dist v (+ (vector-ref dist u) 1))
          (enqueue! q v)))
      (loop)))

  (values dist farthest-node)) ; Return distances and the farthest node found

(define (chasing-game n edges a b)
  ; Build adjacency list
  (define adj (make-vector n '())) ; Adjacency list as a vector of lists
  (for ([edge edges])
    (define u (vector-ref edge 0))
    (define v (vector-ref edge 1))
    ; Add v to u's list and u to v's list
    (vector-set! adj u (cons v (vector-ref adj u)))
    (vector-set! adj v (cons u (vector-ref adj v))))

  ; Calculate distances from A's starting node
  (define-values (da _) (bfs a n adj))
  ; Calculate distances from B's starting node
  (define-values (db _) (bfs b n adj))

  ; Calculate max_depth for each node (maximum distance from node to any other node in the tree)
  ; This uses two BFS traversals to find the diameter endpoints.
  ; First BFS from an arbitrary node (0) to find one endpoint of the diameter (farthest-from-0).
  (define-values (dist-from-0 farthest-from-0) (bfs 0 n adj))
  ; Second BFS from farthest-from-0 to find the other endpoint of the diameter (farthest-from-f0).
  (define-values (dist-from-f0 farthest-from-f0) (bfs farthest-from-0 n adj))
  ; Third BFS from farthest-from-f0 to get distances from that endpoint.
  (define-values (dist-from-f1 _) (bfs farthest-from-f0 n adj))

  ; max_depth[i] is the maximum of distances from i to the two diameter endpoints.
  (define max-depth (make-vector n 0))
  (for ([i (in-range n)])
    (vector-set! max-depth i (max (vector-ref dist-from-f0 i) (vector-ref dist-from-f1 i))))

  ; Determine the minimum number of moves A needs to catch B
  (define ans 0)
  (for ([u (in-range n)])
    (cond
      ; Case 1: B has a lead (A is farther from u than B is from u)
      ; B can try to escape. The maximum number of moves B can survive
      ; by running to the farthest point from u is max_depth[u].
      ; A must be prepared for this, so the game will last at least max_depth[u] moves.
      [(> (vector-ref da u) (vector-ref db u))
       (set! ans (max ans (vector-ref max-depth u)))]
      ; Case 2: A has a lead or is equal (A is closer to u or at the same distance as B is from u)
      ; A can force a meeting at node u. A reaches u in da[u] moves.
      ; B reaches u in db[u] moves. A can wait at u if da[u] < db[u].
      ; The total moves for A to catch B at u is db[u].
      ; A must be prepared for this, so the game will last at least db[u] moves.
      [else
       (set! ans (max ans (vector-ref db u)))]))
  ans)