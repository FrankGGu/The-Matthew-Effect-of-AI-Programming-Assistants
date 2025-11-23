#lang racket

(define (solution n edges queries)
  ;; Constants
  (define LOGN 14) ; ceil(log2(10000)) is 14
  (define MAXW 26) ; Edge weights are 1 to 26

  ;; Global mutable data structures
  (define adj (make-vector n '())) ; Adjacency list
  (define depth (make-vector n 0)) ; Depth of each node from root (node 0)
  (define parent (make-vector LOGN (make-vector n -1))) ; parent[k][i] is 2^k-th ancestor of i
  (define root-path-counts (make-vector n (make-vector MAXW 0))) ; root-path-counts[i][w] is count of weight w+1 on path from root to i

  ;; 1. Build adjacency list
  (for-each
   (lambda (edge)
     (let ((u (vector-ref edge 0))
           (v (vector-ref edge 1))
           (w (vector-ref edge 2)))
       (vector-set! adj u (cons (cons v w) (vector-ref adj u)))
       (vector-set! adj v (cons (cons u w) (vector-ref adj v)))))
   edges)

  ;; 2. DFS for initial depth, parent[0], and root-path-counts
  (define (dfs u p d current-counts)
    (vector-set! depth u d)
    (vector-set! (vector-ref parent 0) u p)
    (vector-set! root-path-counts u (vector-copy current-counts)) ; Store a copy of current-counts
    (for-each
     (lambda (edge)
       (let ((v (car edge))
             (w (cdr edge)))
         (when (not (= v p))
           (let ((next-counts (vector-copy current-counts)))
             (vector-set! next-counts (- w 1) (+ (vector-ref next-counts (- w 1)) 1))
             (dfs v u (+ d 1) next-counts)))))
     (vector-ref adj u)))

  (dfs 0 -1 0 (make-vector MAXW 0)) ; Start DFS from node 0 (root) with parent -1, depth 0, and empty counts

  ;; 3. Build parent table for binary lifting
  (for ([k (range 1 LOGN)])
    (for ([i (range n)]) ; Iterate through actual nodes 0 to n-1
      (let ((intermediate-parent (vector-ref (vector-ref parent (- k 1)) i)))
        (when (not (= intermediate-parent -1))
          (vector-set! (vector-ref parent k) i
                       (vector-ref (vector-ref parent (- k 1)) intermediate-parent))))))

  ;; 4. LCA function
  (define (get-lca u v)
    ;; Ensure depth[v] >= depth[u]
    (when (> (vector-ref depth u) (vector-ref depth v))
      (let ((temp u)) (set! u v) (set! v temp)))

    ;; Lift v to the same depth as u
    (for ([k (range (- LOGN 1) -1 -1)])
      (when (and (not (= (vector-ref (vector-ref parent k) v) -1)) ; Check if 2^k-th ancestor exists
                 (>= (vector-ref depth v) (+ (vector-ref depth u) (expt 2 k))))
        (set! v (vector-ref (vector-ref parent k) v))))

    ;; If u is an ancestor of v (or u == v), then u is the LCA
    (if (= u v)
        u
        (begin
          ;; Lift both u and v simultaneously
          (for ([k (range (- LOGN 1) -1 -1)])
            (when (and (not (= (vector-ref (vector-ref parent k) u) -1)) ; Check if ancestors exist
                       (not (= (vector-ref (vector-ref parent k) v) -1))
                       (not (= (vector-ref (vector-ref parent k) u) (vector-ref (vector-ref parent k) v))))
              (set! u (vector-ref (vector-ref parent k) u))
              (set! v (vector-ref (vector-ref parent k) v))))
          ;; The parent of u (or v) is the LCA
          (vector-ref (vector-ref parent 0) u))))

  ;; 5. Process queries
  (define results '())
  (for-each
   (lambda (query)
     (let ((u (vector-ref query 0))
           (v (vector-ref query 1)))
       (let ((lca (get-lca u v)))
         (let ((path-len (+ (vector-ref depth u) (vector-ref depth v) (- (* 2 (vector-ref depth lca))))))
           (let ((path-edge-counts (make-vector MAXW 0)))
             (for ([w-idx (range MAXW)])
               (vector-set! path-edge-counts w-idx
                            (+ (vector-ref (vector-ref root-path-counts u) w-idx)
                               (vector-ref (vector-ref root-path-counts v) w-idx)
                               (- (* 2 (vector-ref (vector-ref root-path-counts lca) w-idx))))))
             (let ((max-freq 0))
               (for ([w-idx (range MAXW)])
                 (set! max-freq (max max-freq (vector-ref path-edge-counts w-idx))))
               (set! results (cons (- path-len max-freq) results)))))))
   queries)

  (reverse results))