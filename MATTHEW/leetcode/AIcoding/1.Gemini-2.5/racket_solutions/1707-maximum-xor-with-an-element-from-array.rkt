(define (solve nums queries)
  ;; Sort nums in ascending order
  (define sorted-nums-vec (list->vector (sort nums <)))

  ;; Augment queries with their original indices and sort them by mi
  (define indexed-queries
    (map (lambda (q idx) (list (car q) (cadr q) idx)) queries (range (length queries))))
  (define sorted-queries (sort indexed-queries (lambda (q1 q2) (< (cadr q1) (cadr q2)))))

  ;; Initialize results array with -1
  (define results (make-vector (length queries) -1))

  ;; Trie node structure: (list child0 child1)
  ;; child0 and child1 are either #f (no child) or another trie-node.
  ;; A trie-node is a mutable list.
  (define (make-trie-node)
    (list #f #f))

  ;; Inserts a number into the Trie
  (define (trie-insert! trie num)
    (let loop ((current-node trie) (bit-idx 29)) ; Max 30 bits for 10^9 (0 to 29)
      (when (>= bit-idx 0)
        (define bit (if (logand num (arithmetic-shift 1 bit-idx)) 1 0))
        (define child (list-ref current-node bit))
        (unless child
          (set! (list-ref current-node bit) (make-trie-node))
          (set! child (list-ref current-node bit))) ; Update child to the newly created node
        (loop child (- bit-idx 1)))))

  ;; Checks if the Trie is empty (i.e., no numbers inserted yet)
  (define (trie-empty? trie)
    (and (not (list-ref trie 0)) (not (list-ref trie 1))))

  ;; Finds the maximum XOR value with 'num' in the Trie
  (define (trie-max-xor trie num)
    (let loop ((current-node trie) (bit-idx 29) (current-xor 0))
      (if (< bit-idx 0)
          current-xor
          (let* ((bit (if (logand num (arithmetic-shift 1 bit-idx)) 1 0))
                 (opposite-bit (- 1 bit))
                 (child-opposite (list-ref current-node opposite-bit))
                 (child-same (list-ref current-node bit)))
            (if child-opposite
                ;; Go opposite to maximize XOR
                (loop child-opposite
                      (- bit-idx 1)
                      (logior current-xor (arithmetic-shift 1 bit-idx)))
                ;; Must go same
                (loop child-same
                      (- bit-idx 1)
                      current-xor))))))

  ;; Main loop
  (define current-trie (make-trie-node))
  (define nums-ptr 0) ; Pointer for sorted-nums-vec

  (for-each (lambda (query-info)
              (define x (car query-info))
              (define m (cadr query-info))
              (define original-idx (caddr query-info))

              ;; Add numbers from sorted-nums-vec that are <= m to the Trie
              (let loop ()
                (when (and (< nums-ptr (vector-length sorted-nums-vec))
                           (<= (vector-ref sorted-nums-vec nums-ptr) m))
                  (trie-insert! current-trie (vector-ref sorted-nums-vec nums-ptr))
                  (set! nums-ptr (+ nums-ptr 1))
                  (loop)))

              ;; If Trie is not empty, find the maximum XOR for the current query
              (unless (trie-empty? current-trie)
                (vector-set! results original-idx (trie-max-xor current-trie x))))
            sorted-queries)

  (vector->list results))