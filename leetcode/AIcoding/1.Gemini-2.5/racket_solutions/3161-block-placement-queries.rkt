#lang racket

(struct Node (
    max-prefix-empty
    max-suffix-empty
    max-total-empty
    is-full
    is-empty
    lazy-state ; 0: empty, 1: full, -1: no lazy
    start-coord ; physical start coord of this node's range
    end-coord   ; physical end coord (exclusive) of this node's range
    length
) #:mutable)

(define (apply-lazy-to-child child-idx lazy-val nodes)
  (let ([child (vector-ref nodes child-idx)])
    (set-Node-lazy-state! child lazy-val)
    (if (= lazy-val 0) ; Set to empty
        (begin
          (set-Node-is-empty! child #t)
          (set-Node-is-full! child #f)
          (set-Node-max-prefix-empty! child (Node-length child))
          (set-Node-max-suffix-empty! child (Node-length child))
          (set-Node-max-total-empty! child (Node-length child)))
        ; Else lazy-val is 1 (Set to full)
        (begin
          (set-Node-is-empty! child #f)
          (set-Node-is-full! child #t)
          (set-Node-max-prefix-empty! child 0)
          (set-Node-max-suffix-empty! child 0)
          (set-Node-max-total-empty! child 0)))))

(define (push-down idx nodes max-nodes)
  (let ([node (vector-ref nodes idx)])
    (when (not (= (Node-lazy-state node) -1))
      (let ([left-child-idx (+ (* 2 idx) 1)]
            [right-child-idx (+ (* 2 idx) 2)])
        (when (< left-child-idx max-nodes) ; Check if children exist
          (apply-lazy-to-child left-child-idx (Node-lazy-state node) nodes)
          (apply-lazy-to-child right-child-idx (Node-lazy-state node) nodes)))
      (set-Node-lazy-state! node -1)))) ; Clear lazy state after pushing down

(define (merge parent-idx left-idx right-idx nodes)
  (let* ([left (vector-ref nodes left-idx)]
         [right (vector-ref nodes right-idx)]
         [parent (vector-ref nodes parent-idx)]

         [new-is-full (and (Node-is-full left) (Node-is-full right))]
         [new-is-empty (and (Node-is-empty left) (Node-is-empty right))]

         [new-max-prefix-empty (if (Node-is-empty left)
                                   (+ (Node-length left) (Node-max-prefix-empty right))
                                   (Node-max-prefix-empty left))]

         [new-max-suffix-empty (if (Node-is-empty right)
                                   (+ (Node-length right) (Node-max-suffix-empty left))
                                   (Node-max-suffix-empty right))]

         [new-max-total-empty (max (Node-max-total-empty left)
                                   (Node-max-total-empty right)
                                   (+ (Node-max-suffix-empty left) (Node-max-prefix-empty right)))])

    (set-Node-max-prefix-empty! parent new-max-prefix-empty)
    (set-Node-max-suffix-empty! parent new-max-suffix-empty)
    (set-Node-max-total-empty! parent new-max-total-empty)
    (set-Node-is-full! parent new-is-full)
    (set-Node-is-empty! parent new-is-empty)
    (set-Node-lazy-state! parent -1) ; Clear lazy state after merge
    (set-Node-start-coord! parent (Node-start-coord left))
    (set-Node-end-coord! parent (Node-end-coord right))
    (set-Node-length! parent (+ (Node-length left) (Node-length right)))))

(define (build-tree idx l r nodes unique-coords)
  (if (= l r)
      (let* ([start (vector-ref unique-coords l)]
             [end (vector-ref unique-coords (+ l 1))]
             [len (- end start)]
             [node (Node len len len #f #t -1 start end len)])
        (vector-set! nodes idx node))
      (let* ([mid (floor (/ (+ l r) 2))]
             [left-child-idx (+ (* 2 idx) 1)]
             [right-child-idx (+ (* 2 idx) 2)])
        (build-tree left-child-idx l mid nodes unique-coords)
        (build-tree right-child-idx (+ mid 1) r nodes unique-coords)
        (vector-set! nodes idx (Node 0 0 0 #f #f -1 ; placeholder, will be merged
                                     (Node-start-coord (vector-ref nodes left-child-idx))
                                     (Node-end-coord (vector-ref nodes right-child-idx))
                                     0))
        (merge idx left-child-idx right-child-idx nodes))))

(define (update idx node-l-comp node-r-comp query-l-phys query-r-phys value nodes max-nodes)
  (let* ([node (vector-ref nodes idx)]
         [node-phys-start (Node-start-coord node)]
         [node-phys-end (Node-end-coord node)])

    (cond
      ;; No overlap
      [(or (>= node-phys-start query-r-phys) (<= node-phys-end query-l-phys))
       (void)] ; Do nothing

      ;; Complete overlap
      [(and (<= query-l-phys node-phys-start) (>= query-r-phys node-phys-end))
       (apply-lazy-to-child idx value nodes)]

      ;; Partial overlap
      [else
       (push-down idx nodes max-nodes)
       (let* ([left-child-idx (+ (* 2 idx) 1)]
              [right-child-idx (+ (* 2 idx) 2)]
              [mid-comp (floor (/ (+ node-l-comp node-r-comp) 2))])
         (update left-child-idx node-l-comp mid-comp query-l-phys query-r-phys value nodes max-nodes)
         (update right-child-idx (+ mid-comp 1) node-r-comp query-l-phys query-r-phys value nodes max-nodes)
         (merge idx left-child-idx right-child-idx nodes))]))

(define (query idx node-l-comp node-r-comp min-x-allowed required-size nodes max-nodes)
  (let* ([node (vector-ref nodes idx)]
         [node-phys-start (Node-start-coord node)]
         [node-phys-end (Node-end-coord node)])

    (cond
      ;; If this node's range is fully occupied or doesn't have enough empty space
      [(or (Node-is-full node) (< (Node-max-total-empty node) required-size))
       -1]

      ;; If this node is a leaf
      [(= node-l-comp node-r-comp)
       (if (and (Node-is-empty node) (>= (Node-length node) required-size))
           (let ([candidate-x (max node-phys-start min-x-allowed)])
             (if (< (+ candidate-x required-size -1) node-phys-end)
                 candidate-x
                 -1))
           -1)]

      ;; General case: Push down lazy and recurse
      [else
       (push-down idx nodes max-nodes)
       (let* ([left-child-idx (+ (* 2 idx) 1)]
              [right-child-idx (+ (* 2 idx) 2)]
              [mid-comp (floor (/ (+ node-l-comp node-r-comp) 2))]

              ;; 1. Check left child
              [res-left (query left-child-idx node-l-comp mid-comp min-x-allowed required-size nodes max-nodes)])
         (if (!= res-left -1)
             res-left
             (let* ([left-child (vector-ref nodes left-child-idx)]
                    [right-child (vector-ref nodes right-child-idx)]
                    ;; 2. Check spanning segment
                    [combined-empty-len (+ (Node-max-suffix-empty left-child) (Node-max-prefix-empty right-child))])
               (if (>= combined-empty-len required-size)
                   (let ([potential-x-start (- (Node-end-coord left-child) (Node-max-suffix-empty left-child))])
                     (if (>= potential-x-start min-x-allowed)
                         potential-x-start
                         ;; If potential-x-start is too small, check right child
                         (query right-child-idx (+ mid-comp 1) node-r-comp min-x-allowed required-size nodes max-nodes)))
                   ;; 3. Check right child
                   (query right-child-idx (+ mid-comp 1) node-r-comp min-x-allowed required-size nodes max-nodes)))))])))

(define (block-placement-queries blocks queries)
  ;; 1. Coordinate Compression
  (let* ([coords-set (make-hash)]
         [add-coord (lambda (c) (hash-set! coords-set c #t))]
         [all-coords (list)])

    (for-each (lambda (block)
                (let ([pos (vector-ref block 0)]
                      [size (vector-ref block 1)])
                  (add-coord pos)
                  (add-coord (+ pos size))))
              blocks)

    (for-each (lambda (query)
                (let ([pos (vector-ref query 0)]
                      [size (vector-ref query 1)])
                  (add-coord pos)
                  (add-coord (+ pos size))))
              queries)

    (set! all-coords (hash-keys coords-set))
    (set! all-coords (sort all-coords <))
    (let* ([unique-coords (list->vector all-coords)]
           [num-compressed-intervals (- (vector-length unique-coords) 1)]
           [max-nodes (* 4 (if (> num-compressed-intervals 0) num-compressed-intervals 1))] ; Max nodes for segment tree
           [nodes (make-vector max-nodes #f)]
           [results (make-vector (vector-length queries) -1)]) ; Initialize results with -1

      ;; Only proceed if there are actual intervals to manage
      (when (> num-compressed-intervals 0)
        ;; 2. Build Segment Tree
        (build-tree 0 0 (- num-compressed-intervals 1) nodes unique-coords)

        ;; 3. Process initial blocks
        (for-each (lambda (block)
                    (let ([pos (vector-ref block 0)]
                          [size (vector-ref block 1)])
                      (update 0 0 (- num-compressed-intervals 1) pos (+ pos size) 1 nodes max-nodes))) ; 1 for occupied
                  blocks)

        ;; 4. Process queries
        (for-each (lambda (query-item)
                    (let ([pos (vector-ref query-item 0)]
                          [size (vector-ref query-item 1)]
                          [id (vector-ref query-item 2)])
                      (let ([ans (query 0 0 (- num-compressed-intervals 1) pos size nodes max-nodes)])
                        (vector-set! results id ans))))
                  queries))

      (vector->list results))))