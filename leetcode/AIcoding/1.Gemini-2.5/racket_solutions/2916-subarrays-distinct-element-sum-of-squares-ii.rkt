#lang racket

(define MOD 1000000007)

(struct seg-node (sum lazy-add) #:mutable #t)

(define (build-seg-tree size)
  (let ([tree (make-vector (* 4 size))])
    (for ([i (in-range (vector-length tree))])
      (vector-set! tree i (seg-node 0 0)))
    tree))

(define (push-down tree node-idx node-start node-end)
  (when (< node-start node-end) ; Only push down if not a leaf node
    (let ([current-node (vector-ref tree node-idx)])
      (when (not (zero? (seg-node-lazy-add current-node)))
        (let ([lazy-val (seg-node-lazy-add current-node)]
              [left-child-idx (+ (* 2 node-idx) 1)]
              [right-child-idx (+ (* 2 node-idx) 2)]
              [mid (floor (/ (+ node-start node-end) 2))])

          ;; Update left child
          (let ([left-child-node (vector-ref tree left-child-idx)]
                [left-range-len (+ (- mid node-start) 1)])
            (set-seg-node-lazy-add! left-child-node
                                    (modulo (+ (seg-node-lazy-add left-child-node) lazy-val) MOD))
            (set-seg-node-sum! left-child-node
                               (modulo (+ (seg-node-sum left-child-node)
                                          (modulo (* lazy-val left-range-len) MOD)) MOD)))

          ;; Update right child
          (let ([right-child-node (vector-ref tree right-child-idx)]
                [right-range-len (+ (- node-end (+ mid 1)) 1)])
            (set-seg-node-lazy-add! right-child-node
                                    (modulo (+ (seg-node-lazy-add right-child-node) lazy-val) MOD))
            (set-seg-node-sum! right-child-node
                               (modulo (+ (seg-node-sum right-child-node)
                                          (modulo (* lazy-val right-range-len) MOD)) MOD)))

          ;; Clear lazy tag for current node
          (set-seg-node-lazy-add! current-node 0))))))

(define (range-add! tree node-idx node-start node-end query-start query-end val)
  (cond
    ;; No overlap
    [(or (> query-start node-end) (< query-end node-start))
     (void)]
    ;; Current node's range is fully contained within query range
    [(and (<= query-start node-start) (>= query-end node-end))
     (let ([current-node (vector-ref tree node-idx)]
           [range-len (+ (- node-end node-start) 1)])
       (set-seg-node-sum! current-node
                          (modulo (+ (seg-node-sum current-node)
                                     (modulo (* val range-len) MOD)) MOD))
       (set-seg-node-lazy-add! current-node
                               (modulo (+ (seg-node-lazy-add current-node) val) MOD)))]
    ;; Partial overlap
    [else
     (push-down tree node-idx node-start node-end)
     (let ([mid (floor (/ (+ node-start node-end) 2))])
       (range-add! tree (+ (* 2 node-idx) 1) node-start mid query-start query-end val)
       (range-add! tree (+ (* 2 node-idx) 2) (+ mid 1) node-end query-start query-end val))
     (let ([current-node (vector-ref tree node-idx)]
           [left-child-node (vector-ref tree (+ (* 2 node-idx) 1))]
           [right-child-node (vector-ref tree (+ (* 2 node-idx) 2))])
       (set-seg-node-sum! current-node
                          (modulo (+ (seg-node-sum left-child-node)
                                     (seg-node-sum right-child-node)) MOD)))]))

(define (query-sum tree node-idx node-start node-end query-start query-end)
  (cond
    ;; No overlap
    [(or (> query-start node-end) (< query-end node-start)) 0]
    ;; Full overlap
    [(and (<= query-start node-start) (>= query-end node-end))
     (seg-node-sum (vector-ref tree node-idx))]
    ;; Partial overlap
    [else
     (push-down tree node-idx node-start node-end)
     (let ([mid (floor (/ (+ node-start node-end) 2))])
       (modulo (+ (query-sum tree (+ (* 2 node-idx) 1) node-start mid query-start query-end)
                  (query-sum tree (+ (* 2 node-idx) 2) (+ mid 1) node-end query-start query-end)) MOD))]))

(define (sum-distinct-squares-ii nums)
  (let* ([N (vector-length nums)]
         [total-ans 0]
         [last-pos (make-hash)] ; Stores last seen index for each number
         [seg-tree (build-seg-tree N)])

    (for ([k (in-range N)])
      (let* ([val (vector-ref nums k)]
             [val-sq (modulo (* val val) MOD)]
             [prev-idx (hash-ref last-pos val -1)])

        ;; Determine the start index for adding val-sq's contribution
        ;; If val is new, it contributes to all subarrays starting from 0 up to k.
        ;; If val appeared before at prev-idx, it contributes to subarrays starting from prev-idx + 1 up to k.
        (let ([start-idx (if (= prev-idx -1) 0 (+ prev-idx 1))])
          (when (<= start-idx k) ; Ensure the range is valid
            (range-add! seg-tree 0 0 (- N 1) start-idx k val-sq)))

        ;; Add the sum of squares of distinct elements for all subarrays ending at k
        ;; (i.e., dp[0] + dp[1] + ... + dp[k]) to the total answer.
        (set! total-ans (modulo (+ total-ans (query-sum seg-tree 0 0 (- N 1) 0 k)) MOD))

        ;; Update the last seen position of the current value
        (hash-set! last-pos val k)))
    total-ans))