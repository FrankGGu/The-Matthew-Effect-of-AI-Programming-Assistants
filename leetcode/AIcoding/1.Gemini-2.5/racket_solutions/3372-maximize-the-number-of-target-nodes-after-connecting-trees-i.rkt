#lang racket

(define (maximize-target-nodes n edges is-target-list)
  (define is-target-vec (list->vector is-target-list))
  (define adj (make-vector n '()))
  (for-each (lambda (edge)
              (let ((u (car edge))
                    (v (cadr edge)))
                (vector-set! adj u (cons v (vector-ref adj u)))
                (vector-set! adj v (cons u (vector-ref adj v)))))
            edges)

  (define f-vals (make-vector n 0)) ; Max target nodes on a path starting at u and going down into its subtree
  (define g-vals (make-vector n 0)) ; Max target nodes on a path starting at u and going up towards its parent
  (define component-id-vec (make-vector n -1))
  (define max-path-from-node-any-direction (make-vector n 0)) ; Max target nodes on a path starting at u and going in any single direction

  (define current-ans 0) ; Stores the max path within any single tree

  (define component-counter 0)
  (define visited-nodes (make-vector n #f))

  ; DFS1: Calculate f-vals (max path down from u)
  (define (dfs1 u parent)
    (vector-set! visited-nodes u #t)
    (vector-set! component-id-vec u component-counter)

    (let ((current-node-target (if (vector-ref is-target-vec u) 1 0)))
      (vector-set! f-vals u current-node-target)

      (define max-child-f-val 0)
      (for-each (lambda (v)
                  (when (not (= v parent))
                    (dfs1 v u)
                    (set! max-child-f-val (max max-child-f-val (vector-ref f-vals v)))))
                (vector-ref adj u))

      (vector-set! f-vals u (+ (vector-ref f-vals u) max-child-f-val))))

  ; DFS2: Calculate g-vals (max path up from u), update current-ans for paths within tree,
  ; and store max-path-from-node-any-direction for inter-tree connections.
  (define (dfs2 u parent)
    (let ((current-node-target (if (vector-ref is-target-vec u) 1 0)))
      ; Calculate g-vals[u]
      (define max-val-from-parent-side 0)
      (when (not (= parent -1))
        (let ((parent-target (if (vector-ref is-target-vec parent) 1 0)))
          (define parent-g-minus-target (- (vector-ref g-vals parent) parent-target))

          ; Find the longest and second longest f-vals among parent's children
          (define parent-children-f-vals '())
          (for-each (lambda (v)
                      (when (not (= v parent)) ; v is a child of parent
                        (set! parent-children-f-vals (cons (vector-ref f-vals v) parent-children-f-vals))))
                    (vector-ref adj parent))
          (set! parent-children-f-vals (sort parent-children-f-vals >))

          (define longest-f-from-parent-children 0)
          (define second-longest-f-from-parent-children 0)

          (when (not (null? parent-children-f-vals))
            (set! longest-f-from-parent-children (car parent-children-f-vals))
            (when (not (null? (cdr parent-children-f-vals)))
              (set! second-longest-f-from-parent-children (cadr parent-children-f-vals))))

          (define val-from-parent-down-other-branch 0)
          (if (= (vector-ref f-vals u) longest-f-from-parent-children) ; If u's f-val was the longest
              (set! val-from-parent-down-other-branch second-longest-f-from-parent-children)
              (set! val-from-parent-down-other-branch longest-f-from-parent-children))

          (set! max-val-from-parent-side (max 0 parent-g-minus-target val-from-parent-down-other-branch))))

      (vector-set! g-vals u (+ current-node-target max-val-from-parent-side))

      ; Update current-ans for paths within this tree
      ; A path through u is (path down from u) + (path up from u) - is_target[u]
      (set! current-ans (max current-ans (+ (vector-ref f-vals u) (vector-ref g-vals u) (- current-node-target))))

      ; Store max_path_from_node_any_direction[u] for connecting trees
      (vector-set! max-path-from-node-any-direction u (max (vector-ref f-vals u) (vector-ref g-vals u)))

      ; Recurse for children
      (for-each (lambda (v)
                  (when (not (= v parent))
                    (dfs2 v u)))
                (vector-ref adj u))))

  ; Main loop to find components and run DFSs
  (for-each (lambda (i)
              (when (not (vector-ref visited-nodes i))
                (dfs1 i -1) ; First DFS to calculate f-vals
                (dfs2 i -1) ; Second DFS to calculate g-vals
                (set! component-counter (+ component-counter 1))))
            (range n))

  ; Now, find the two largest max_path_from_node_any_direction values from different components
  (define component-max-path-any-direction (make-vector component-counter 0))
  (for-each (lambda (i)
              (let ((comp-id (vector-ref component-id-vec i)))
                (when (not (= comp-id -1)) ; Node belongs to a component
                  (vector-set! component-max-path-any-direction comp-id
                               (max (vector-ref component-max-path-any-direction comp-id)
                                    (vector-ref max-path-from-node-any-direction i))))))
            (range n))

  (set! component-max-path-any-direction (sort (vector->list component-max-path-any-direction) >))

  (when (>= (length component-max-path-any-direction) 2)
    (set! current-ans (max current-ans (+ (car component-max-path-any-direction) (cadr component-max-path-any-direction)))))

  current-ans)