#lang racket

(define (maximize-value-of-function n index values k)
  (define MAX_LOG_K 31) ; For k up to 10^9, k+1 can be up to 10^9+1. log2(10^9+1) is approx 29.89, so we need up to 2^29 or 2^30. 31 covers it.

  ; next-node[j][i] stores the node reached after 2^j steps from i
  (define next-node (build-vector MAX_LOG_K (lambda (_) (make-vector n 0))))
  ; sum-values[j][i] stores the sum of values for 2^j nodes starting from i (inclusive)
  (define sum-values (build-vector MAX_LOG_K (lambda (_) (make-vector n 0))))

  ; Initialize for j = 0 (1 step, 2^0 nodes)
  (for ([i (in-range n)])
    (vector-set! (vector-ref next-node 0) i (vector-ref index i))
    (vector-set! (vector-ref sum-values 0) i (vector-ref values i)))

  ; Precompute for j > 0
  (for ([j (in-range 1 MAX_LOG_K)])
    (for ([i (in-range n)])
      (define prev-next-node (vector-ref (vector-ref next-node (- j 1)) i))
      (vector-set! (vector-ref next-node j) i (vector-ref (vector-ref next-node (- j 1)) prev-next-node))
      (vector-set! (vector-ref sum-values j) i (+ (vector-ref (vector-ref sum-values (- j 1)) i)
                                                   (vector-ref (vector-ref sum-values (- j 1)) prev-next-node)))))

  (define max-total-value -1)

  ; Iterate through all possible starting positions
  (for ([start-pos (in-range n)])
    (define current-sum-of-values 0)
    (define current-node start-pos)
    (define num-nodes-to-sum (+ k 1))

    ; Use binary lifting to sum values for num-nodes-to-sum steps
    (for ([j (in-range (- MAX_LOG_K 1) -1 -1)])
      (when (bitwise-bit-set? num-nodes-to-sum j)
        (set! current-sum-of-values (+ current-sum-of-values (vector-ref (vector-ref sum-values j) current-node)))
        (set! current-node (vector-ref (vector-ref next-node j) current-node))))

    ; Update the maximum total value
    (set! max-total-value (max max-total-value (+ start-pos current-sum-of-values))))

  max-total-value)