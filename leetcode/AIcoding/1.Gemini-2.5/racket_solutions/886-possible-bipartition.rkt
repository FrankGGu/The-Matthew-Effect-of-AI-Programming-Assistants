(define (possible-bipartition n dislikes)
  (define adj (make-vector (+ n 1) '())) ; Adjacency list for 1-indexed nodes
  (define colors (make-vector (+ n 1) -1)) ; -1: uncolored, 0: color A, 1: color B

  ;; Build adjacency list
  (for-each
   (lambda (pair)
     (define u (car pair))
     (define v (cadr pair))
     (vector-set! adj u (cons v (vector-ref adj u)))
     (vector-set! adj v (cons u (vector-ref adj v))))
   dislikes)

  ;; DFS helper function
  ;; Returns #t if the subgraph starting from node u can be bipartitioned, #f otherwise.
  (define (dfs u color)
    (vector-set! colors u color) ; Assign color to u

    (let loop ((neighbors (vector-ref adj u)))
      (cond
        [(empty? neighbors) #t] ; All neighbors processed, no conflict found
        [else
         (define v (car neighbors))
         (cond
           [(= (vector-ref colors v) -1) ; If neighbor v is uncolored
            (if (dfs v (- 1 color)) ; Recurse with opposite color
                (loop (cdr neighbors)) ; If successful, continue with next neighbor
                #f)] ; If recursive call returns #f, propagate #f
           [(= (vector-ref colors v) color) ; If neighbor v has the same color
            #f] ; Conflict found, return #f
           [else ; Neighbor v is colored with the opposite color, continue
            (loop (cdr neighbors))])]))
  )

  ;; Main loop to iterate through all nodes
  (let loop ((i 1))
    (cond
      [(> i n) #t] ; All nodes processed, no conflicts found
      [(= (vector-ref colors i) -1) ; If node is uncolored
       (if (dfs i 0) ; Start DFS with color 0
           (loop (+ i 1)) ; If successful, continue with next node
           #f)] ; If DFS returns #f, propagate #f
      [else ; Node is already colored, continue
       (loop (+ i 1))]))
  )