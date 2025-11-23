#lang racket

(define (min-edge-reversals n edges)
  ;; Build adjacency list
  ;; adj[u] will store (list v cost)
  ;; cost is 0 if u -> v is an original edge (traverse in original direction)
  ;; cost is 1 if v -> u is an original edge (meaning we reverse it to go u -> v)
  (define adj (make-vector n '()))

  (for-each (lambda (edge)
              (let ((u (car edge))
                    (v (cadr edge)))
                ;; Edge u -> v, cost 0 to traverse u -> v
                (vector-set! adj u (cons (list v 0) (vector-ref adj u)))
                ;; Edge v -> u, cost 1 to traverse u -> v (reversing v -> u)
                (vector-set! adj v (cons (list u 1) (vector-ref adj v)))))
            edges)

  ;; DFS function to calculate the minimum number of reversals needed in the
  ;; subtree rooted at 'u' (when considering the graph as an undirected tree
  ;; rooted at 0) to make all nodes in that subtree reachable from 'u'.
  ;; 'p' is the parent of 'u' in the DFS tree, to avoid traversing back up.
  (define (dfs u p)
    (let loop ((neighbors (vector-ref adj u))
               (current-reversals 0))
      (if (empty? neighbors)
          current-reversals
          (let* ((neighbor-info (car neighbors))
                 (v (car neighbor-info))
                 (cost (cadr neighbor-info)))
            (if (= v p)
                ;; Skip the parent node to avoid infinite loops and correctly define subtrees
                (loop (cdr neighbors) current-reversals)
                ;; Recurse for the child node and add its cost (edge cost + subtree reversals)
                (loop (cdr neighbors) (+ current-reversals cost (dfs v u))))))))

  ;; Start DFS from node 0, with -1 as a placeholder for a non-existent parent
  (dfs 0 -1))