(define (count-visited-nodes edges)
  (define n (vector-length edges))
  (define ans (make-vector n 0))
  (define state (make-vector n 0)) ; 0: unvisited, 1: visiting (in current path), 2: visited (computed)
  (define path-stack-vec (make-vector n 0)) ; Stores nodes in current DFS path
  (define path-stack-ptr 0) ; Current number of elements in path-stack-vec
  (define path-indices (make-vector n -1)) ; Maps node to its index in path-stack-vec

  (define (dfs u)
    ;; If already computed, return immediately
    (when (= (vector-ref state u) 2)
      (void))

    ;; Mark u as visiting and add to current path
    (vector-set! state u 1)
    (vector-set! path-indices u path-stack-ptr)
    (vector-set! path-stack-vec path-stack-ptr u)
    (set! path-stack-ptr (+ path-stack-ptr 1))

    (let* ((v (vector-ref edges u))
           (v-state (vector-ref state v)))
      (cond
        ((= v-state 1) ; Cycle detected: v is currently in the path
         (let* ((cycle-start-idx (vector-ref path-indices v))
                (cycle-len (- path-stack-ptr cycle-start-idx)))
           ;; All nodes in the cycle (from v to u) have their answer set to cycle-len
           (let loop-cycle-nodes ((idx cycle-start-idx))
             (when (< idx path-stack-ptr)
               (let ((node (vector-ref path-stack-vec idx)))
                 (vector-set! ans node cycle-len)
                 (vector-set! state node 2)) ; Mark as computed
               (loop-cycle-nodes (+ idx 1))))))
        ((= v-state 0) ; v is unvisited, continue DFS
         (dfs v) ; Recurse
         ;; After dfs(v) returns, ans[v] is computed and state[v] is 2.
         ;; If u's answer is not yet computed (i.e., u was not part of a cycle found by dfs(v))
         (when (= (vector-ref state u) 1)
           (vector-set! ans u (+ 1 (vector-ref ans v)))
           (vector-set! state u 2)))
        ((= v-state 2) ; v is already visited and computed
         ;; ans[v] is already computed.
         ;; If u's answer is not yet computed
         (when (= (vector-ref state u) 1)
           (vector-set! ans u (+ 1 (vector-ref ans v)))
           (vector-set! state u 2)))))

    ;; Remove u from path stack and reset its path index
    (set! path-stack-ptr (- path-stack-ptr 1))
    (vector-set! path-indices u -1))

  ;; Main loop to start DFS for unvisited nodes
  (for ((i (range n)))
    (when (= (vector-ref state i) 0)
      (dfs i)))
  ans)