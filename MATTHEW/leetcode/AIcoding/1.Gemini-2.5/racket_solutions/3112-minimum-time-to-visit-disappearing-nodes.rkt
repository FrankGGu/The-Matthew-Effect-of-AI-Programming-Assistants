#lang racket
(require data/heap)
(require racket/vector)

(define (minimum-time-to-visit-disappearing-nodes n edges disappearing-time)
  ;; A sufficiently large number representing infinity.
  ;; Max path time is N * max_edge_length = 5e4 * 1e4 = 5e8.
  ;; Disappearing time can be up to 1e9.
  ;; So 1e10 is a safe infinity.
  (define +inf.0 (expt 10 10)) 

  ;; dist[i] stores the minimum time to reach node i such that
  ;; this time is less than disappearing_time[i].
  ;; If no such path exists, it remains +inf.0.
  (define dist (make-vector n +inf.0))
  (vector-set! dist 0 0) ; Starting node 0 is reachable at time 0.

  ;; Adjacency list: adj[u] is a list of (v, length) pairs.
  (define adj (make-vector n '()))
  (for-each
   (lambda (edge)
     (define u (list-ref edge 0))
     (define v (list-ref edge 1))
     (define length (list-ref edge 2))
     ;; Add edge for u -> v
     (vector-set! adj u (cons (list v length) (vector-ref adj u)))
     ;; Add edge for v -> u (undirected graph)
     (vector-set! adj v (cons (list u length) (vector-ref adj v))))
   edges)

  ;; Priority queue stores (time, node) pairs, ordered by time (min-heap).
  (define pq (make-heap (lambda (a b) (< (car a) (car b)))))
  (heap-add! pq (list 0 0)) ; Start with node 0 at time 0.

  (while (not (heap-empty? pq))
    (define current-item (heap-remove-min! pq))
    (define current-time (car current-item))
    (define u (cadr current-item))

    ;; If we've already found a shorter path to u (that respects disappearing time),
    ;; or if this path is not better than the current best path to u, skip.
    (when (<= current-time (vector-ref dist u))
      ;; Check if node u has disappeared by the time we arrive.
      ;; If current-time >= disappearing_time[u], we cannot use u to travel further.
      (when (< current-time (vector-ref disappearing-time u))
        (for-each
         (lambda (neighbor-info)
           (define v (car neighbor-info))
           (define length (cadr neighbor-info))
           (define new-time (+ current-time length))

           ;; If this new path to v is shorter than any previously found path to v
           (when (< new-time (vector-ref dist v))
             ;; And if v has not disappeared by the time we arrive via this new path
             (when (< new-time (vector-ref disappearing-time v))
               (vector-set! dist v new-time)
               (heap-add! pq (list new-time v)))))
         (vector-ref adj u)))))

  ;; Convert +inf.0 values to -1 as per problem requirements.
  (build-vector n
                (lambda (i)
                  (if (= (vector-ref dist i) +inf.0)
                      -1
                      (vector-ref dist i)))))