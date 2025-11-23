(define BIT_MAX_IDX 30) ; Numbers up to 2 * 10^9 fit in 31 bits (0 to 30)

(struct trie-node (children count) #:mutable) ; children is a vector of 2 trie-nodes or #f

(define (make-trie-node)
  (trie-node (vector #f #f) 0)) ; Initialize children with #f for no child

(define (trie-insert! root num)
  (let loop ((curr root) (bit-idx BIT_MAX_IDX))
    (set-trie-node-count! curr (+ (trie-node-count curr) 1))
    (when (>= bit-idx 0)
      (let* ((bit (if (logbit? bit-idx num) 1 0))
             (child (vector-ref (trie-node-children curr) bit)))
        (unless child
          (set! child (make-trie-node))
          (vector-set! (trie-node-children curr) bit child))
        (loop child (- bit-idx 1))))))

(define (trie-remove! root num)
  (let loop ((curr root) (bit-idx BIT_MAX_IDX))
    (set-trie-node-count! curr (- (trie-node-count curr) 1))
    (when (>= bit-idx 0)
      (let* ((bit (if (logbit? bit-idx num) 1 0))
             (child (vector-ref (trie-node-children curr) bit)))
        (loop child (- bit-idx 1))))))

(define (trie-query root num)
  (let loop ((curr root) (bit-idx BIT_MAX_IDX) (current-xor 0))
    (if (< bit-idx 0)
        current-xor
        (let* ((bit (if (logbit? bit-idx num) 1 0))
               (desired-bit (if (= bit 0) 1 0)) ; Try to get the opposite bit
               (opposite-child (vector-ref (trie-node-children curr) desired-bit)))
          (if (and opposite-child (> (trie-node-count opposite-child) 0))
              ; Go down the path that gives 1 for current bit in XOR
              (loop opposite-child (- bit-idx 1) (bitwise-ior current-xor (arithmetic-shift 1 bit-idx)))
              ; Go down the path that gives 0 for current bit in XOR
              (let ((same-child (vector-ref (trie-node-children curr) bit)))
                (loop same-child (- bit-idx 1) current-xor)))))))

(define (maximum-strong-pair-xor-ii nums)
  (define n (vector-length nums))

  (define sorted-nums (vector->list nums))
  (set! sorted-nums (sort sorted-nums <))
  (set! nums (list->vector sorted-nums)) ; Convert back to vector for O(1) access

  (define root (make-trie-node))
  (define max-xor 0)
  (define left 0)

  (for ([right (in-range n)])
    (let* ((y (vector-ref nums right))
           ; For a strong pair (x, y) with x <= y, we need y <= 2x, which means x >= y/2.
           ; x-min-bound is the smallest x can be.
           (x-min-bound (ceiling (/ y 2.0)))) 

      ; Remove numbers from the Trie that are too small for the current y
      ; i.e., nums[left] < y/2
      (while (and (< left right) (< (vector-ref nums left) x-min-bound))
        (trie-remove! root (vector-ref nums left))
        (set! left (+ left 1)))

      ; Insert current y into the Trie
      (trie-insert! root y)

      ; Query the Trie for the maximum XOR with y.
      ; All numbers x currently in the Trie satisfy:
      ; 1. x >= nums[left] (because nums is sorted and left pointer only moves forward)
      ; 2. nums[left] >= y/2 (due to the while loop condition)
      ; 3. x <= y (because x was inserted when it was nums[right_prev] for some right_prev <= right, and nums is sorted)
      ; So, for any x in the Trie, y/2 <= x <= y, which implies (x, y) is a strong pair.
      (set! max-xor (max max-xor (trie-query root y)))))
  max-xor)