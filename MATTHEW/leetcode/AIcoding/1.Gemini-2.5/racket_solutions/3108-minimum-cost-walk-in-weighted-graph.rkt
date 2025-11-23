#lang racket

(define parent #f)
(define component-or-sum #f)

(define (find i)
  (if (= (vector-ref parent i) i)
      i
      (let ((root (find (vector-ref parent i))))
        (vector-set! parent i root)
        root)))

(define (union u v w)
  (let ((root-u (find u))
        (root-v (find v)))
    ;; If u and v are in different components, merge them.
    (when (not (= root-u root-v))
      ;; Merge root-v's component into root-u's component.
      (vector-set! parent root-v root-u)
      ;; Update the component-or-sum for the new root (root-u)
      ;; by ORing its current sum with the sum of the merged component (root-v).
      (vector-set! component-or-sum root-u
                   (bitwise-ior (vector-ref component-or-sum root-u)
                                (vector-ref component-or-sum root-v))))
    ;; After potential merge, or if already in the same component,
    ;; OR the edge weight `w` into the component's total sum.
    ;; `(find u)` ensures we get the current root of u's component,
    ;; which might have changed if a merge occurred.
    (let ((final-root (find u)))
      (vector-set! component-or-sum final-root
                   (bitwise-ior (vector-ref component-or-sum final-root) w)))))

(define (minimum-cost-walk n edges queries)
  ;; Initialize DSU structures.
  ;; Each node is initially its own parent and its component-or-sum is 0.
  (set! parent (make-vector n))
  (set! component-or-sum (make-vector n))
  (for ([i (in-range n)])
    (vector-set! parent i i)
    (vector-set! component-or-sum i 0))

  ;; Process all edges to build connected components and their aggregated OR-sums.
  (for ([edge edges])
    (let ([u (car edge)]
          [v (cadr edge)]
          [w (caddr edge)])
      (union u v w)))

  ;; Process all queries.
  (for/list ([query queries])
    (let ([start (car query)]
          [end (cadr query)])
      (cond
        ;; If start and end are the same node, the cost is 0 (no edges traversed).
        [(= start end) 0]
        ;; Otherwise, check if they are in the same connected component.
        [else
         (let ((root-start (find start))
               (root-end (find end)))
           (if (= root-start root-end)
               ;; If they are in the same component, return the pre-calculated
               ;; bitwise OR sum of all edge weights in that component.
               (vector-ref component-or-sum root-start)
               ;; If they are not connected, return -1.
               -1))]))))