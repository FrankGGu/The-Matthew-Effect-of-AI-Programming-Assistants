#lang racket

(struct trie-node (children count) #:mutable)

(define trie-root (trie-node (vector #f #f) 0))

(define NUM-BITS 29)

(define (trie-insert num)
  (let loop ((curr trie-root) (bit-idx (- NUM-BITS 1)))
    (set-trie-node-count! curr (+ (trie-node-count curr) 1))
    (when (>= bit-idx 0)
      (let* ((bit (bitwise-and (arithmetic-shift num (- bit-idx)) 1))
             (child (vector-ref (trie-node-children curr) bit)))
        (unless child
          (set! child (trie-node (vector #f #f) 0))
          (vector-set! (trie-node-children curr) bit child))
        (loop child (- bit-idx 1))))))

(define (trie-remove num)
  (let loop ((curr trie-root) (bit-idx (- NUM-BITS 1)))
    (set-trie-node-count! curr (- (trie-node-count curr) 1))
    (when (>= bit-idx 0)
      (let* ((bit (bitwise-and (arithmetic-shift num (- bit-idx)) 1))
             (child (vector-ref (trie-node-children curr) bit)))
        ;; Child must exist if the number was inserted and is being removed.
        ;; The 'when child' is a safety check, but should always be true.
        (when child
          (loop child (- bit-idx 1)))))))

(define (trie-query num)
  (let loop ((curr trie-root) (bit-idx (- NUM-BITS 1)) (current-xor 0))
    (cond
      ((< bit-idx 0)
       current-xor)
      (else
       (let* ((bit (bitwise-and (arithmetic-shift num (- bit-idx)) 1))
              (opposite-bit (bitwise-xor bit 1))
              (opposite-child (vector-ref (trie-node-children curr) opposite-bit))
              (same-child (vector-ref (trie-node-children curr) bit)))
         ;; Try to go for the opposite bit to maximize XOR.
         ;; Only if the opposite path exists and has numbers passing through it (count > 0).
         (if (and opposite-child (> (trie-node-count opposite-child) 0))
             ;; Go for the opposite bit and add 2^bit_idx to current_xor
             (loop opposite-child (- bit-idx 1) (bitwise-ior current-xor (arithmetic-shift 1 bit-idx)))
             ;; Otherwise, must go for the same bit.
             ;; We assume same-child exists and has count > 0 if curr's count > 0.
             (loop same-child (- bit-idx 1) current-xor)))))))

(define (maximum-genetic-difference parents nums queries)
  (let* ((n (vector-length parents))
         (adj (make-vector n '())) ; Adjacency list for the tree
         ;; query-map: node_id -> list of queries (pair (val . query_idx))
         (query-map (make-vector n '()))
         (results (make-vector (length queries) 0)))

    ;; Build adjacency list from parent array
    (for ((i (in-range n)))
      (let ((p (vector-ref parents i)))
        (when (>= p 0) ; -1 indicates the root, so skip
          (vector-set! adj p (cons i (vector-ref adj p))))))

    ;; Store queries grouped by node for efficient lookup during DFS
    (for ((q-idx (in-range (length queries))))
      (let* ((query (list-ref queries q-idx))
             (u (list-ref query 0))
             (val (list-ref query 1)))
        (vector-set! query-map u (cons (cons val q-idx) (vector-ref query-map u)))))

    ;; Depth-First Search function
    (define (dfs u)
      ;; 1. Add nums[u] to the Trie. This makes nums[u] available for queries
      ;;    in the subtree rooted at u, and also for queries on paths from u's descendants.
      (trie-insert (vector-ref nums u))

      ;; 2. Process all queries associated with the current node u.
      ;;    The Trie now contains all numbers from the path from root to u,
      ;;    and also numbers from subtrees of ancestors (which will be removed later).
      (for ((q (in-list (vector-ref query-map u))))
        (let* ((val (car q))
               (q-idx (cdr q)))
          (vector-set! results q-idx (trie-query val))))

      ;; 3. Recursively call DFS for all children of u.
      (for ((v (in-list (vector-ref adj u))))
        (dfs v))

      ;; 4. After visiting the entire subtree of u, remove nums[u] from the Trie.
      ;;    This effectively "rolls back" the Trie state, ensuring that when DFS
      ;;    returns to u's parent, nums[u] is no longer considered.
      (trie-remove (vector-ref nums u)))

    ;; Find the root node (the one with parent -1) to start DFS
    (let ((root-node -1))
      (for ((i (in-range n)))
        (when (= (vector-ref parents i) -1)
          (set! root-node i)))
      (dfs root-node))

    ;; Convert the results vector to a list as required by LeetCode's Racket signature.
    (vector->list results)))