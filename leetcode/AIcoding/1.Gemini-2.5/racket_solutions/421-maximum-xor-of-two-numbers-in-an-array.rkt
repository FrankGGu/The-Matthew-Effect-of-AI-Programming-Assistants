#lang racket

(struct trie-node (children) #:transparent) ; children is a hash table {0 -> trie-node, 1 -> trie-node}

(define (make-trie-node)
  (trie-node (make-hash)))

(define (insert-num root num)
  (let loop ((curr root) (i 30)) ; Iterate from most significant bit (30) down to least significant (0)
    (when (>= i 0)
      (let* ((bit (bitwise-and (arithmetic-shift num (- i)) 1)) ; Get the i-th bit
             (children (trie-node-children curr)))
        (unless (hash-has-key? children bit)
          (hash-set! children bit (make-trie-node)))
        (loop (hash-ref children bit) (- i 1))))))

(define (find-max-xor-for-num root num)
  (let loop ((curr root) (i 30) (current-xor 0))
    (if (>= i 0)
        (let* ((bit (bitwise-and (arithmetic-shift num (- i)) 1))
               (opposite-bit (bitwise-xor bit 1)) ; Try to find the opposite bit to maximize XOR
               (children (trie-node-children curr)))
          (if (hash-has-key? children opposite-bit)
              ; If opposite bit path exists, take it and add 2^i to current-xor
              (loop (hash-ref children opposite-bit)
                    (- i 1)
                    (bitwise-ior current-xor (arithmetic-shift 1 i)))
              ; Otherwise, take the same bit path (it must exist as all numbers are inserted)
              (loop (hash-ref children bit)
                    (- i 1)
                    current-xor)))
        current-xor)))

(define (find-maximum-xor nums)
  (define root (make-trie-node))

  ; Insert all numbers into the Trie
  (for-each (lambda (num) (insert-num root num)) nums)

  (define max-xor 0)

  ; For each number, find the maximum XOR it can form with any other number in the Trie
  (for-each (lambda (num)
              (set! max-xor (max max-xor (find-max-xor-for-num root num))))
            nums)
  max-xor)