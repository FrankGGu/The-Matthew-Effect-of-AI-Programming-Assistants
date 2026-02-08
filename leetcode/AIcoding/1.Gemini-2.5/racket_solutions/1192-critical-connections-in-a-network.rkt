(define (critical-connections n connections)
  ;; Adjacency list for the graph
  (define adj (make-vector n '()))
  (for-each
   (lambda (conn)
     (define u (car conn))
     (define v (cadr conn))
     (set-vector-element! adj u (cons v (vector-ref adj u)))
     (set-vector-element! adj v (cons u (vector-ref adj v))))
   connections)

  ;; Discovery times for each node, initialized to -1 (unvisited)
  (define disc (make-vector n -1))
  ;; Low-link values for each node, initialized to -1
  (define low (make-vector n -1))
  ;; Global time counter, wrapped in a box for mutability
  (define current-time (box 0))
  ;; List to store critical connections, wrapped in a box
  (define result (box '()))

  ;; Depth-First Search function to find bridges
  (define (dfs u p) ; u: current node, p: parent node
    ;; Set discovery time and low-link value for the current node
    (set-vector-element! disc u (unbox current-time))
    (set-vector-element! low u (unbox current-time))
    ;; Increment global time counter
    (set-box! current-time (+ (unbox current-time) 1))

    ;; Iterate over all neighbors of u
    (for-each
     (lambda (v)
       ;; Skip the parent node to avoid treating it as a back-edge
       (when (not (= v p))
         (if (= (vector-ref disc v) -1) ; If v is not visited
             (begin
               ;; Recurse on v
               (dfs v u)
               ;; Update low-link value of u based on v's low-link value
               (set-vector-element! low u (min (vector-ref low u) (vector-ref low v)))
               ;; If low-link value of v is greater than discovery time of u,
               ;; then (u, v) is a bridge
               (when (> (vector-ref low v) (vector-ref disc u))
                 (set-box! result (cons (list u v) (unbox result)))))
             ;; If v is visited and not the parent, it's a back-edge
             (set-vector-element! low u (min (vector-ref low u) (vector-ref disc v))))))
     (vector-ref adj u)))

  ;; Iterate through all nodes to ensure all connected components are visited
  (for-each
   (lambda (i)
     (when (= (vector-ref disc i) -1) ; If node i has not been visited
       (dfs i -1))) ; Start DFS from i, with -1 indicating no parent
   (build-list n identity)) ; Creates a list (0 1 ... n-1)

  ;; Return the list of critical connections
  (unbox result))