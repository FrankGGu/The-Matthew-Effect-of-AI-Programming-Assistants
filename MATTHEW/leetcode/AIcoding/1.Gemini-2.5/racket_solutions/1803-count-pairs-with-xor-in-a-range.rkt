#lang racket

(struct trie-node (children pass-count) #:mutable)

(define MAX_BITS 15) ; Max value for nums[i], low, high is 2*10^4, which fits in 15 bits (2^14=16384, 2^15=32768).

(define (make-trie-node)
  (trie-node (vector #f #f) 0)) ; #f represents a null child

(define (trie-insert! root num)
  (let loop ((curr root) (bit-idx (- MAX_BITS 1)))
    (set-trie-node-pass-count! curr (+ (trie-node-pass-count curr) 1))
    (when (>= bit-idx 0)
      (let* ((bit (bitwise-and (arithmetic-shift num (- bit-idx)) 1))
             (child (vector-ref (trie-node-children curr) bit)))
        (unless child
          (set! child (make-trie-node))
          (vector-set! (trie-node-children curr) bit child))
        (loop child (sub1 bit))))))

(define (count-less-than root x limit)
  (let loop ((curr root) (bit-idx (- MAX_BITS 1)))
    (cond
      ((or (not curr) (< bit-idx 0)) 0) ; Base case: node is null or all bits processed
      (else
       (let* ((x-bit (bitwise-and (arithmetic-shift x (- bit-idx)) 1))
              (limit-bit (bitwise-and (arithmetic-shift limit (- bit-idx)) 1))
              (total-count 0))
         (if (= limit-bit 1)
             ; If limit-bit is 1:
             ; Case 1: The XOR bit is 0 (which is less than limit-bit).
             ; This means y-bit must be x-bit. All numbers in this branch satisfy the < condition
             ; at this bit position, regardless of lower bits.
             (let ((child-node-0 (vector-ref (trie-node-children curr) x-bit)))
               (when child-node-0
                 (set! total-count (+ total-count (trie-node-pass-count child-node-0))))

               ; Case 2: The XOR bit is 1 (which matches limit-bit).
               ; This means y-bit must be (1 - x-bit).
               ; We must continue the recursive search to ensure remaining bits are less.
               (let ((child-node-1 (vector-ref (trie-node-children curr) (bitwise-xor 1 x-bit))))
                 (+ total-count (loop child-node-1 x limit (sub1 bit-idx))))
               )
             ; If limit-bit is 0:
             ; Case 1: The XOR bit must be 0 (which matches limit-bit).
             ; This means y-bit must be x-bit.
             ; We must continue the recursive search to ensure remaining bits are less.
             (let ((child-node-0 (vector-ref (trie-node-children curr) x-bit)))
               (loop child-node-0 x limit (sub1 bit-idx))
               ))))))

(define (count-pairs nums low high)
  (let ((root (make-trie-node))
        (total-pairs 0))
    (for-each (lambda (num)
                (set! total-pairs
                      (+ total-pairs
                         (- (count-less-than root num (+ high 1))
                            (count-less-than root num low))))
                (trie-insert! root num))
              nums)
    total-pairs))