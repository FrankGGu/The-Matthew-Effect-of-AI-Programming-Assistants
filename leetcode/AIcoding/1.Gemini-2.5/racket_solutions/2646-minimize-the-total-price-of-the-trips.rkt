#lang racket

(define (minimize-total-price n edges price trips)
  ;; Adjacency list
  (define adj (make-vector n '()))
  (for-each (lambda (edge)
              (define u (car edge))
              (define v (cadr edge))
              (vector-set! adj u (cons v (vector-ref adj u)))
              (vector-set! adj v (cons u (vector-ref adj v))))
            edges)

  ;; LCA precomputation
  (define LOGN (add1 (inexact->exact (floor (log n 2)))))
  (define depth (make-vector n 0))
  (define parent (make-vector n (make-vector LOGN -1))) ; parent[u][k] = 2^k-th ancestor of u

  (letrec ((dfs-lca-prep
            (lambda (u p d)
              (vector-set! depth u d)
              (vector-set! (vector-ref parent u) 0 p)
              (for-each (lambda (v)
                          (when (not (= v p))
                            (dfs-lca-prep v u (add1 d))))
                        (vector-ref adj u)))))
    (dfs-lca-prep 0 -1 0)) ; Start DFS from node 0, parent -1, depth 0

  ;; Fill parent table for binary lifting
  (for ([k (range 1 LOGN)])
    (for ([u (range n)])
      (define p-u-k-1 (vector-ref (vector-ref parent u) (sub1 k)))
      (when (not (= p-u-k-1 -1))
        (define p-puk-k-1 (vector-ref (vector-ref parent p-u-k-1) (sub1 k)))
        (vector-set! (vector-ref parent u) k p-puk-k-1))))

  ;; Function to get LCA
  (define (get-lca u-start v-start)
    (call/cc
     (lambda (return-lca) ; return-lca is the continuation to exit get-lca
       (let ([u u-start] [v v-start])
         ;; Ensure u is at least as deep as v (swap if v is deeper)
         (when (> (vector-ref depth u) (vector-ref depth v))
           (let ([temp u])
             (set! u v)
             (set! v temp)))

         ;; Lift v to the same depth as u
         (for ([k (range (sub1 LOGN) -1 -1)])
           (let ([p-v-k (vector-ref (vector-ref parent v) k)])
             (when (and (not (= p-v-k -1))
                        (>= (vector-ref depth p-v-k) (vector-ref depth u)))
               (set! v p-v-k))))

         ;; If u and v are now the same, that's the LCA
         (when (= u v)
           (return-lca u))

         ;; Lift u and v simultaneously until their parents are the same
         (for ([k (range (sub1 LOGN) -1 -1)])
           (let ([p-u-k (vector-ref (vector-ref parent u) k)]
                 [p-v-k (vector-ref (vector-ref parent v) k)])
             (when (and (not (= p-u-k -1))
                        (not (= p-v-k -1))
                        (not (= p-u-k p-v-k)))
               (set! u p-u-k)
               (set! v p-v-k))))
         ;; The parent of u (or v) is the LCA
         (vector-ref (vector-ref parent u) 0)))))

  ;; Node trip counts (difference array method)
  (define node-trip-counts (make-vector n 0))
  (for-each (lambda (trip)
              (define u (car trip))
              (define v (cadr trip))
              (define lca (get-lca u v))
              (vector-set! node-trip-counts u (add1 (vector-ref node-trip-counts u)))
              (vector-set! node-trip-counts v (add1 (vector-ref node-trip-counts v)))
              (vector-set! node-trip-counts lca (sub1 (vector-ref node-trip-counts lca)))
              (when (not (= (vector-ref (vector-ref parent lca) 0) -1))
                (vector-set! node-trip-counts (vector-ref (vector-ref parent lca) 0)
                             (sub1 (vector-ref node-trip-counts (vector-ref (vector-ref parent lca) 0))))))
            trips)

  ;; Propagate counts from children to parents
  (letrec ((dfs-propagate-counts
            (lambda (u p)
              (for-each (lambda (v)
                          (when (not (= v p))
                            (dfs-propagate-counts v u)
                            (vector-set! node-trip-counts u (+ (vector-ref node-trip-counts u)
                                                               (vector-ref node-trip-counts v)))))
                        (vector-ref adj u)))))
    (dfs-propagate-counts 0 -1))

  ;; Dynamic programming for minimum cost
  ;; dp[u][0] = min cost for subtree u, u's price not halved
  ;; dp[u][1] = min cost for subtree u, u's price halved
  (define dp0 (make-vector n 0))
  (define dp1 (make-vector n 0))

  (letrec ((dfs-dp
            (lambda (u p)
              (define current-cost-u-not-halved (* (vector-ref node-trip-counts u) (vector-ref price u)))
              (define current-cost-u-halved (* (vector-ref node-trip-counts u) (quotient (vector-ref price u) 2)))

              (define children-cost-u-not-halved 0)
              (define children-cost-u-halved 0)

              (for-each (lambda (v)
                          (when (not (= v p))
                            (dfs-dp v u)
                            (set! children-cost-u-not-halved
                                  (+ children-cost-u-not-halved (min (vector-ref dp0 v) (vector-ref dp1 v))))
                            (set! children-cost-u-halved
                                  (+ children-cost-u-halved (vector-ref dp0 v)))))
                        (vector-ref adj u))

              (vector-set! dp0 u (+ current-cost-u-not-halved children-cost-u-not-halved))
              (vector-set! dp1 u (+ current-cost-u-halved children-cost-u-halved)))))
    (dfs-dp 0 -1))

  (min (vector-ref dp0 0) (vector-ref dp1 0)))