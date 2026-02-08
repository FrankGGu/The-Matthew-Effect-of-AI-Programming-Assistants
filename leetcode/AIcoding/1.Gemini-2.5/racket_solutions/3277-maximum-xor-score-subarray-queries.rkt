#lang racket

(struct immutable-trie-node (children max-idx) #:transparent)

(define MAX-BITS 20) ; Max value < 2^20

(define (make-empty-immutable-trie-node)
  (immutable-trie-node (vector #f #f) -1))

(define (immutable-trie-insert root val idx)
  (let loop ((curr root) (bit-idx (- MAX-BITS 1)))
    (let ((new-max-idx (max (immutable-trie-node-max-idx curr) idx)))
      (cond
        ((< bit-idx 0)
         (make-immutable-trie-node (immutable-trie-node-children curr) new-max-idx))
        (else
         (let* ((bit (if (logbit? bit-idx val) 1 0))
                (old-child (vector-ref (immutable-trie-node-children curr) bit))
                (new-child (loop (or old-child (make-empty-immutable-trie-node)) (- bit-idx 1))))
           (let ((new-children (vector-copy (immutable-trie-node-children curr))))
             (vector-set! new-children bit new-child)
             (make-immutable-trie-node new-children new-max-idx))))))))

(define (immutable-trie-query root val min-idx)
  (let loop ((curr root) (bit-idx (- MAX-BITS 1)) (current-xor 0))
    (cond
      ((or (not curr) (< bit-idx 0)) current-xor)
      (else
       (let* ((target-bit (if (logbit? bit-idx val) 1 0))
              (preferred-child-bit (- 1 target-bit))
              (preferred-child (vector-ref (immutable-trie-node-children curr) preferred-child-bit))
              (other-child (vector-ref (immutable-trie-node-children curr) target-bit)))
         (cond
           ;; Try to go to the preferred child (to maximize XOR) if it exists and satisfies min-idx
           ((and preferred-child (>= (immutable-trie-node-max-idx preferred-child) min-idx))
            (loop preferred-child (- bit-idx 1) (bitwise-ior current-xor (arithmetic-shift 1 bit-idx))))
           ;; Otherwise, go to the other child if it exists and satisfies min-idx
           ((and other-child (>= (immutable-trie-node-max-idx other-child) min-idx))
            (loop other-child (- bit-idx 1) current-xor))
           ;; No path satisfies min-idx, so we can't maximize further with this branch
           (else
            current-xor)))))))

(define (solve nums queries)
  (let* ((n (vector-length nums))
         (pxor (make-vector (+ n 1)))
         (ans (make-vector (length queries)))
         (trie-roots (make-vector (+ n 1))))

    ;; Calculate prefix XOR sums
    (vector-set! pxor 0 0)
    (for ((i (in-range n)))
      (vector-set! pxor (+ i 1) (bitwise-xor (vector-ref pxor i) (vector-ref nums i))))

    ;; Build persistent Tries
    ;; trie-roots[k] will be the root of a Trie containing pxor[0]...pxor[k]
    (vector-set! trie-roots 0 (make-empty-immutable-trie-node))
    (vector-set! trie-roots 0 (immutable-trie-insert (vector-ref trie-roots 0) (vector-ref pxor 0) 0))

    (for ((k (in-range 1 (+ n 1))))
      (vector-set! trie-roots k (immutable-trie-insert (vector-ref trie-roots (- k 1)) (vector-ref pxor k) k)))

    ;; Process queries
    (for ((q-idx (in-range (length queries))))
      (let* ((query (list-ref queries q-idx))
             (L (list-ref query 0))
             (R (list-ref query 1))
             (max-xor-score 0))
        ;; For each possible right endpoint 'j' of a subarray in [L, R]
        ;; The subarray is nums[i...j], its XOR sum is pxor[j+1] ^ pxor[i]
        ;; We need to find max(pxor[j+1] ^ pxor[i]) for L <= i <= j
        (for ((j (in-range L (+ R 1))))
          (let* ((current-pxor (vector-ref pxor (+ j 1)))
                 ;; The Trie for pxor[j] contains pxor[0]...pxor[j]
                 ;; We need pxor[i] where L <= i <= j.
                 ;; So, we query trie-roots[j] for pxor[i] that maximizes XOR with current-pxor,
                 ;; and its index 'i' is >= L.
                 (trie-at-j (vector-ref trie-roots j))
                 (found-xor (immutable-trie-query trie-at-j current-pxor L)))
            (set! max-xor-score (max max-xor-score found-xor))))
        (vector-set! ans q-idx max-xor-score)))
    ans))