#lang racket

(struct node (value count) #:transparent)

(define (better? node1 node2)
  (> (node-value node1) (node-value node2)))

(define (merge-nodes node1 node2)
  (if (better? node1 node2) node1 node2))

(define *seg-tree* #f)
(define *seg-tree-size* 0)

(define (init-seg-tree M)
  (set! *seg-tree-size* M)
  (set! *seg-tree* (make-vector (* 4 M) (node 0 0))))

(define (seg-update idx new-val-node)
  (define (update-rec tree-idx low high)
    (cond
      ((= low high) ; Leaf node
       (when (better? new-val-node (vector-ref *seg-tree* tree-idx))
         (vector-set! *seg-tree* tree-idx new-val-node)))
      (else
       (let ([mid (quotient (+ low high) 2)])
         (if (<= idx mid)
             (update-rec (* 2 tree-idx) low mid)
             (update-rec (+ (* 2 tree-idx) 1) (+ mid 1) high))
         ; After updating children, update current node by merging children's values
         (vector-set! *seg-tree* tree-idx
                      (merge-nodes (vector-ref *seg-tree* (* 2 tree-idx))
                                   (vector-ref *seg-tree* (+ (* 2 tree-idx) 1))))))))
  (update-rec 1 0 (sub1 *seg-tree-size*)))

(define (seg-query q-low q-high)
  (define (query-rec tree-idx low high)
    (cond
      ((or (> low q-high) (< high q-low)) (node 0 0)) ; No overlap
      ((and (>= low q-low) (<= high q-high)) (vector-ref *seg-tree* tree-idx)) ; Full overlap
      (else
       (let ([mid (quotient (+ low high) 2)])
         (merge-nodes
          (query-rec (* 2 tree-idx) low mid)
          (query-rec (+ (* 2 tree-idx) 1) (+ mid 1) high))))))
  (query-rec 1 0 (sub1 *seg-tree-size*)))

(define (training-plan-iii plans)
  ; 1. Coordinate compress durations to map them to 0-indexed integers
  (let* ([all-durations (map car plans)]
         [sorted-unique-durations (sort (remove-duplicates all-durations) <)]
         [duration-map (make-hash)]
         [M (length sorted-unique-durations)]) ; M is the number of unique durations

    (for-each (lambda (d idx) (hash-set! duration-map d idx))
              sorted-unique-durations
              (range M))

    ; 2. Initialize the segment tree with M leaves
    (init-seg-tree M)

    ; 3. Iterate through the plans in their original order
    (for-each (lambda (plan-item)
                (let* ([d (car plan-item)]
                       [v (cadr plan-item)]
                       [compressed-d (hash-ref duration-map d)])

                  ; Query the segment tree for the maximum (value, count)
                  ; from all plans processed so far (j < current_i)
                  ; whose duration is less than or equal to the current plan's duration (d_j <= d_i).
                  ; This corresponds to querying the range [0, compressed-d].
                  (let* ([prev-max-node (seg-query 0 compressed-d)]
                         [new-val (+ (node-value prev-max-node) v)]
                         [new-count (+ (node-count prev-max-node) 1)]
                         [candidate-node (node new-val new-count)])

                    ; Update the segment tree at `compressed-d` with this new candidate.
                    ; This ensures that `seg-tree[compressed-d]` stores the maximum value
                    ; of a valid plan set where the latest plan has duration `compressed-d`.
                    (seg-update compressed-d candidate-node))))

    ; 4. After processing all plans, the maximum value in the entire segment tree
    ; (querying the full range [0, M-1]) is the answer.
    (node-value (seg-query 0 (sub1 M)))))