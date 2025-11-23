#lang racket

(define (maximum-weighted-k-edge-path n edges k)
  (define neg-inf (- (expt 10 18))) ; A sufficiently small number for -infinity

  ; Build adjacency list
  ; adj[u] = list of (list v weight)
  (define adj (make-vector n '()))
  (for-each (lambda (edge)
              (define u (car edge))
              (define v (cadr edge))
              (define w (caddr edge))
              (vector-set! adj u (cons (list v w) (vector-ref adj u))))
            edges)

  ; dp[i][j] = maximum weight of a path ending at node j using exactly i edges
  ; dp is a vector of vectors
  (define dp (make-vector (+ k 1) #f)) ; Outer vector for k+1 edge counts

  ; Initialize dp[0]: A path of 0 edges has 0 weight for all nodes
  (define dp0 (make-vector n 0))
  (vector-set! dp 0 dp0)

  ; Initialize dp[i] for i > 0 with neg-inf
  (for ([i (in-range 1 (+ k 1))])
    (vector-set! dp i (make-vector n neg-inf)))

  ; Fill DP table
  (for ([i (in-range 1 (+ k 1))]) ; Iterate for number of edges from 1 to k
    (define current-dp-row (vector-ref dp i))
    (define prev-dp-row (vector-ref dp (- i 1)))
    (for ([u (in-range n)]) ; Iterate through all possible source nodes 'u'
      ; Only consider paths that reached 'u' with 'i-1' edges
      (when (not (= (vector-ref prev-dp-row u) neg-inf))
        ; For each edge (u, v) with weight w
        (for-each (lambda (edge-info)
                    (define v (car edge-info))
                    (define w (cadr edge-info))
                    ; Update dp[i][v] = max(dp[i][v], dp[i-1][u] + w)
                    (vector-set! current-dp-row v
                                 (max (vector-ref current-dp-row v)
                                      (+ (vector-ref prev-dp-row u) w))))
                  (vector-ref adj u)))))

  ; Find the maximum value in dp[k]
  (define max-weight neg-inf)
  (define final-dp-row (vector-ref dp k))
  (for ([val (in-vector final-dp-row)])
    (set! max-weight (max max-weight val)))

  ; If max-weight is still neg-inf, no path of k edges exists
  (if (= max-weight neg-inf)
      -1
      max-weight))