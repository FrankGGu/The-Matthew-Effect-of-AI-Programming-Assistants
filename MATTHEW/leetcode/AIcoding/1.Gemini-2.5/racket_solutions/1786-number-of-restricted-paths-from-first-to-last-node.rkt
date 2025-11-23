#lang racket

(require data/heap)

(define (count-restricted-paths n edges)
  (define MOD 1000000007)

  ;; Step 1: Build the graph (adjacency list)
  ;; graph[u] = list of (v . weight)
  (define graph (make-vector (+ n 1) '()))
  (for-each
   (lambda (edge)
     (define u (car edge))
     (define v (cadr edge))
     (define w (caddr edge))
     (vector-set! graph u (cons (cons v w) (vector-ref graph u)))
     (vector-set! graph v (cons (cons u w) (vector-ref graph v))))
   edges)

  ;; Step 2: Dijkstra's algorithm to find shortest distances from all nodes to node n
  ;; dist[i] = shortest distance from i to n
  (define dist (make-vector (+ n 1) +inf.0))
  (vector-set! dist n 0)

  ;; Priority queue: (heap-min) stores (distance . node)
  (define pq (make-heap (lambda (a b) (< (car a) (car b)))))
  (heap-add! pq (cons 0 n)) ; Start Dijkstra from node n

  (let loop ()
    (when (not (heap-empty? pq))
      (define current (heap-min-key pq))
      (heap-remove-min! pq)
      (define d (car current))
      (define u (cdr current))

      ;; If we found a shorter path to 'u' already, this entry is stale. Skip.
      (when (> d (vector-ref dist u))
        (loop))

      ;; Otherwise, process neighbors
      (for-each
       (lambda (neighbor-pair)
         (define v (car neighbor-pair))
         (define weight (cdr neighbor-pair))
         (when (< (+ (vector-ref dist u) weight) (vector-ref dist v))
           (vector-set! dist v (+ (vector-ref dist u) weight))
           (heap-add! pq (cons (vector-ref dist v) v))))
       (vector-ref graph u))
      (loop)))

  ;; Step 3: Dynamic Programming (DFS with memoization) to count restricted paths
  ;; dp[u] = number of restricted paths from u to n
  (define dp (make-vector (+ n 1) -1)) ; -1 indicates uncomputed

  (define (dfs u)
    (cond
      [(= u n) 1] ; Base case: if at node n, there's 1 path (itself)
      [(not (= (vector-ref dp u) -1)) (vector-ref dp u)] ; Memoized result
      [else
       (define current-paths 0)
       (for-each
        (lambda (neighbor-pair)
          (define v (car neighbor-pair))
          ;; Restricted path condition: dist[u] > dist[v]
          (when (> (vector-ref dist u) (vector-ref dist v))
            (set! current-paths (modulo (+ current-paths (dfs v)) MOD))))
        (vector-ref graph u))
       (vector-set! dp u current-paths)
       current-paths]))

  ;; Start DFS from node 1
  (dfs 1))