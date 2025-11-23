(define (count-complete-components n edges)
  ;; Initialize graph as an adjacency list using a vector of lists
  (define graph (make-vector n '()))
  (for-each (lambda (edge)
              (define u (car edge))
              (define v (cadr edge))
              ;; Add v to u's adjacency list
              (vector-set! graph u (cons v (vector-ref graph u)))
              ;; Add u to v's adjacency list (undirected graph)
              (vector-set! graph v (cons u (vector-ref graph v))))
            edges)

  ;; Initialize a boolean vector to keep track of visited nodes during DFS
  (define visited (make-vector n #f))

  ;; Counter for the number of complete components found
  (define complete-components-count 0)

  ;; Iterate through all nodes to find connected components
  (for ([i (in-range n)])
    ;; If node i has not been visited, it's the start of a new component
    (unless (vector-ref visited i)
      ;; Variables to store properties of the current component
      (define component-nodes-list '())
      (define component-edges-degree-sum 0) ; Sum of degrees of nodes in the component

      ;; Depth-First Search (DFS) function to traverse a component
      (define (dfs-component node)
        ;; Mark the current node as visited
        (vector-set! visited node #t)
        ;; Add the node to the list of nodes in the current component
        (set! component-nodes-list (cons node component-nodes-list))
        ;; Add the degree of the current node to the total degree sum for the component
        (set! component-edges-degree-sum (+ component-edges-degree-sum (length (vector-ref graph node))))

        ;; Recursively call DFS for unvisited neighbors
        (for-each (lambda (neighbor)
                    (unless (vector-ref visited neighbor)
                      (dfs-component neighbor)))
                  (vector-ref graph node)))

      ;; Start DFS from node i to find all nodes and edges in its component
      (dfs-component i)

      ;; Calculate the number of vertices and edges in the found component
      (define num-vertices (length component-nodes-list))
      ;; The sum of degrees is twice the number of edges in the component
      (define num-edges (/ component-edges-degree-sum 2))

      ;; Check if the component is complete:
      ;; A component with 'k' vertices is complete if it has k * (k - 1) / 2 edges.
      (when (= num-edges (/ (* num-vertices (- num-vertices 1)) 2))
        (set! complete-components-count (+ complete-components-count 1)))))

  ;; Return the total count of complete components
  complete-components-count)