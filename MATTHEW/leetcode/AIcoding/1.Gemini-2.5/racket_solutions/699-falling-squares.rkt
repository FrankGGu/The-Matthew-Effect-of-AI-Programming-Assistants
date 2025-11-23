#lang racket

(define (falling-squares positions)
  ;; Handle empty input case first
  (when (empty? positions)
    (list))

  ;; 1. Collect all unique x-coordinates
  (define (collect-coords positions)
    (define coord-set (make-hash))
    (for-each (lambda (pos)
                (define left (car pos))
                (define side (cadr pos))
                (hash-set! coord-set left #t)
                (hash-set! coord-set (+ left side) #t))
              positions)
    (sort (hash-keys coord-set) <))

  (define coords (collect-coords positions))
  (define M (length coords))

  ;; M will be at least 2 because 1 <= side_length, so left < left + side_length.
  ;; Thus, there will always be at least two distinct coordinates if positions is not empty.

  ;; 2. Coordinate compression map
  (define coord-to-idx (make-hash))
  (for ([coord coords] [idx (in-naturals)])
    (hash-set! coord-to-idx coord idx))

  ;; 3. Segment Tree Implementation
  ;; The segment tree operates on indices corresponding to the compressed coordinate segments.
  ;; If M coordinates, there are M-1 segments. Indices 0 to M-2.
  (define N-segments (- M 1))
  (define tree-size (* 4 N-segments)) ; Standard size for a segment tree array
  (define tree (make-vector tree-size 0)) ; Stores max height in range
  (define lazy (make-vector tree-size 0)) ; Stores pending range updates (max value to set)

  ;; Helper to push down lazy updates from parent to children
  (define (push-down tree-idx)
    (define lazy-val (vector-ref lazy tree-idx))
    (when (> lazy-val 0) ; If there's a pending update
      (define left-child (+ (* 2 tree-idx) 1))
      (define right-child (+ (* 2 tree-idx) 2))

      ;; Apply lazy-val to children's tree and lazy values
      ;; We take max because updates are "set to max(current, new_value)"
      (vector-set! tree left-child (max (vector-ref tree left-child) lazy-val))
      (vector-set! lazy left-child (max (vector-ref lazy left-child) lazy-val))

      (vector-set! tree right-child (max (vector-ref tree right-child) lazy-val))
      (vector-set! lazy right-child (max (vector-ref lazy right-child) lazy-val))

      (vector-set! lazy tree-idx 0))) ; Reset lazy tag for current node after pushing it down

  ;; Update segment tree: set max height in range [query-L, query-R] to value
  ;; query-L and query-R are compressed segment indices.
  (define (update tree-idx range-start range-end query-L query-R value)
    (cond
      ;; Case 1: Current node's range is outside the query range (no overlap)
      ((or (> range-start query-R) (< range-end query-L))
       (void))
      ;; Case 2: Current node's range is fully contained within the query range
      ((and (<= query-L range-start) (<= range-end query-R))
       (vector-set! tree tree-idx (max (vector-ref tree tree-idx) value))
       (vector-set! lazy tree-idx (max (vector-ref lazy tree-idx) value)))
      ;; Case 3: Partial overlap, need to recurse
      (else
       (push-down tree-idx) ; Push down pending updates before recursing
       (define mid (quotient (+ range-start range-end) 2))
       (update (+ (* 2 tree-idx) 1) range-start mid query-L query-R value)
       (update (+ (* 2 tree-idx) 2) (+ mid 1) range-end query-L query-R value)
       ;; After children are updated, update current node's value from children
       (vector-set! tree tree-idx (max (vector-ref tree (+ (* 2 tree-idx) 1))
                                       (vector-ref tree (+ (* 2 tree-idx) 2)))))))

  ;; Query segment tree: get max height in range [query-L, query-R]
  ;; query-L and query-R are compressed segment indices.
  (define (query tree-idx range-start range-end query-L query-R)
    (cond
      ;; Case 1: Current node's range is outside the query range (no overlap)
      ((or (> range-start query-R) (< range-end query-L)) 0)
      ;; Case 2: Current node's range is fully contained within the query range
      ((and (<= query-L range-start) (<= range-end query-R)) (vector-ref tree tree-idx))
      ;; Case 3: Partial overlap, need to recurse
      (else
       (push-down tree-idx) ; Push down pending updates before recursing
       (define mid (quotient (+ range-start range-end) 2))
       (define left-max (query (+ (* 2 tree-idx) 1) range-start mid query-L query-R))
       (define right-max (query (+ (* 2 tree-idx) 2) (+ mid 1) range-end query-L query-R))
       (max left-max right-max))))

  ;; 4. Main Logic
  (define max-overall-height 0)
  (define result-list-accumulator '()) ; Build list in reverse for efficiency, then reverse at end

  (for-each (lambda (pos)
              (define left (car pos))
              (define side (cadr pos))
              (define right (+ left side))

              (define query-L-idx (hash-ref coord-to-idx left))
              (define query-R-idx (hash-ref coord-to-idx right))

              ;; The segment tree operates on indices from 0 to N-segments-1.
              ;; The square covers segments from `query-L-idx` up to `query-R-idx - 1`.
              (define current-max-h
                (query 0 0 (- N-segments 1) query-L-idx (- query-R-idx 1)))

              (define new-square-height (+ current-max-h side))

              ;; Update the segment tree with the new height for the covered range
              (update 0 0 (- N-segments 1) query-L-idx (- query-R-idx 1) new-square-height)

              ;; Update the overall maximum height
              (set! max-overall-height (max max-overall-height new-square-height))
              ;; Add to accumulator
              (set! result-list-accumulator (cons max-overall-height result-list-accumulator)))
            positions)

  (reverse result-list-accumulator))