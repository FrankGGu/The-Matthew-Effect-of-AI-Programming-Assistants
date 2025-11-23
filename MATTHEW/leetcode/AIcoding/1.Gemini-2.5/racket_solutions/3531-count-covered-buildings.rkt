(define (count-covered-buildings buildings)
  (if (null? buildings)
      0
      (let* ([grouped-by-xy (make-hash)]
             ;; Step 1: Group buildings by (x, y) and keep only the one with the maximum height.
             ;; This ensures that for any given (x, y) coordinate, only the tallest building is considered,
             ;; as any shorter building at the same (x, y) would be covered by the tallest one.
             [_ (for-each (lambda (b)
                            (let* ([x (car b)]
                                   [y (cadr b)]
                                   [h (caddr b)]
                                   [key (list x y)])
                              (hash-update! grouped-by-xy key (lambda (current-h) (max current-h h)) 0)))
                          buildings)]
             [unique-buildings (map (lambda (key) (list (car key) (cadr key) (hash-ref grouped-by-xy key)))
                                    (hash-keys grouped-by-xy))]
             ;; Step 2: Sort the unique buildings.
             ;; Sort by x ascending, then y ascending. This order is crucial for the sweep-line approach
             ;; when iterating in reverse.
             [sorted-buildings (sort unique-buildings
                                     (lambda (b1 b2)
                                       (let* ([x1 (car b1)] [y1 (cadr b1)]
                                              [x2 (car b2)] [y2 (cadr b2)])
                                         (cond
                                           ((< x1 x2) #t)
                                           ((> x1 x2) #f)
                                           ((< y1 y2) #t)
                                           (else #f)))))]
             ;; Step 3: Coordinate compress the y values.
             ;; This is needed because y coordinates can be large (10^9), but the number of unique y values is at most N.
             ;; A segment tree operates on 0-indexed contiguous ranges.
             [y-values (map cadr sorted-buildings)]
             [unique-y-values (sort (remove-duplicates y-values) <)]
             [y-map (make-hash)]
             [_ (for-each (lambda (y-val idx) (hash-set! y-map y-val idx))
                          unique-y-values
                          (build-list (length unique-y-values) identity))]
             [max-y-compressed-index (sub1 (length unique-y-values))]
             ;; Step 4: Initialize a segment tree.
             ;; The segment tree will store the maximum height encountered for a given compressed y-coordinate range.
             ;; Its size is based on the number of unique y-coordinates.
             [tree-size (length unique-y-values)]
             [segment-tree (make-vector (* 4 (if (> tree-size 0) tree-size 1)) 0)] ; Use 4*N for segment tree size, handle tree-size 0 case

             ;; Segment tree helper functions (nested)
             ;; `segment-tree-update!` updates the maximum value at a specific index in the segment tree.
             (define (segment-tree-update! tree node start end idx val)
               (if (= start end)
                   (vector-set! tree node (max (vector-ref tree node) val))
                   (let ([mid (quotient (+ start end) 2)])
                     (if (<= idx mid)
                         (segment-tree-update! tree (* 2 node) start mid idx val)
                         (segment-tree-update! tree (+ (* 2 node) 1) (+ mid 1) end idx val)))
                   (vector-set! tree node (max (vector-ref tree (* 2 node)) (vector-ref tree (+ (* 2 node) 1))))))

             ;; `segment-tree-query` queries the maximum value in a given range [left, right] in the segment tree.
             (define (segment-tree-query tree node start end left right)
               (cond
                 ((or (> start right) (> left end)) 0) ; No overlap or invalid range, return identity for max
                 ((and (<= left start) (<= end right)) (vector-ref tree node)) ; Complete overlap
                 (else
                  (let ([mid (quotient (+ start end) 2)])
                    (max (segment-tree-query tree (* 2 node) start mid left right)
                         (segment-tree-query tree (+ (* 2 node) 1) (+ mid 1) end left right))))))

             [uncovered-count 0])

        ;; Step 5: Iterate through sorted buildings in reverse order to count uncovered ones.
        ;; For each building (x, y, h), we query the segment tree for the maximum height of any
        ;; previously processed building (x', y', h') such that x' >= x and y' >= y.
        ;; If h is greater than this maximum, the current building is uncovered.
        (for-each (lambda (b)
                    (let* ([x (car b)]
                           [y (cadr b)]
                           [h (caddr b)]
                           [y-compressed-idx (hash-ref y-map y)])
                      ;; Query for max height in the range [y-compressed-idx, max-y-compressed-index].
                      ;; This range corresponds to y' >= y.
                      ;; Since we iterate in reverse of (x asc, y asc) order, any building processed earlier
                      ;; (i.e., with a larger index in `sorted-buildings`) will have x' >= x.
                      (let ([max-h-in-range (segment-tree-query segment-tree 1 0 max-y-compressed-index y-compressed-idx max-y-compressed-index)])
                        (when (> h max-h-in-range)
                          (set! uncovered-count (add1 uncovered-count))))
                      ;; After checking, update the segment tree with the current building's height
                      ;; so it can cover subsequent buildings.
                      (segment-tree-update! segment-tree 1 0 max-y-compressed-index y-compressed-idx h)))
                  (reverse sorted-buildings))
        uncovered-count)))