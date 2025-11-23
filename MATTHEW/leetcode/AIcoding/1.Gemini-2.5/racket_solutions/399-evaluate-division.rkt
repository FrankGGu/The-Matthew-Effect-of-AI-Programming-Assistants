#lang racket

(define (calc-equation equations values queries)
  (define graph (make-hash))

  ;; Build the graph
  (for ([i (in-range (length equations))])
    (define eq (list-ref equations i))
    (define val (list-ref values i))
    (define var1 (list-ref eq 0))
    (define var2 (list-ref eq 1))

    ;; Add var1 / var2 = val
    (hash-set! graph var1 (hash-union (hash-ref graph var1 (make-hash)) (hash var2 val)))
    ;; Add var2 / var1 = 1 / val
    (hash-set! graph var2 (hash-union (hash-ref graph var2 (make-hash)) (hash var1 (/ 1.0 val)))))

  ;; Depth-First Search function to find path product
  (define (dfs start-node end-node current-product visited)
    (cond
      ;; If already visited, this path is a cycle or redundant, stop exploring it
      [(hash-has-key? visited start-node) -1.0]
      ;; If start-node is the target, we found a path, return the accumulated product
      [(equal? start-node end-node) current-product]
      [else
       ;; Mark current node as visited for this path
       (hash-set! visited start-node #t)
       (define neighbors (hash-ref graph start-node (make-hash)))
       (define result -1.0)
       ;; Iterate through neighbors
       (for ([(neighbor weight) (in-hash neighbors)])
         ;; If a path is already found, stop exploring further from this node
         (when (equal? result -1.0)
           (define res (dfs neighbor end-node (* current-product weight) visited))
           ;; If a valid path was found from neighbor, update result and break
           (when (not (equal? res -1.0))
             (set! result res))))
       ;; No need to remove from visited here because a new 'visited' hash is used for each query's DFS
       result]))

  (define results (make-list (length queries) 0.0))

  ;; Process each query
  (for ([i (in-range (length queries))])
    (define query (list-ref queries i))
    (define var1 (list-ref query 0))
    (define var2 (list-ref query 1))

    (cond
      ;; If variables are the same, result is 1.0 as per problem statement
      [(equal? var1 var2)
       (list-set! results i 1.0)]
      ;; If either variable is not in the graph, no division is possible
      [(or (not (hash-has-key? graph var1)) (not (hash-has-key? graph var2)))
       (list-set! results i -1.0)]
      ;; Otherwise, perform DFS to find the path product
      [else
       (define visited (make-hash)) ; Fresh visited set for each query
       (list-set! results i (dfs var1 var2 1.0 visited))]))

  results)