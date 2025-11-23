#lang racket

(struct trie-node (child0 child1) #:mutable)

(define MAX-BITS 31)

(define (insert-num root num)
  (let loop ((current-node root) (bit-idx (- MAX-BITS 1)))
    (when (>= bit-idx 0)
      (let* ((bit (if (bitwise-bit-set? num bit-idx) 1 0)))
        (if (= bit 0)
            (let ((child (trie-node-child0 current-node)))
              (if child
                  (loop child (- bit-idx 1))
                  (let ((new-node (trie-node #f #f)))
                    (set-trie-node-child0! current-node new-node)
                    (loop new-node (- bit-idx 1)))))
            (let ((child (trie-node-child1 current-node)))
              (if child
                  (loop child (- bit-idx 1))
                  (let ((new-node (trie-node #f #f)))
                    (set-trie-node-child1! current-node new-node)
                    (loop new-node (- bit-idx 1))))))))))

(define (find-max-xor root num)
  (let loop ((current-node root) (bit-idx (- MAX-BITS 1)) (current-xor 0))
    (if (< bit-idx 0)
        current-xor
        (let* ((bit (if (bitwise-bit-set? num bit-idx) 1 0))
               (desired-bit (- 1 bit)))
          (if (= desired-bit 0)
              (let ((child-for-desired (trie-node-child0 current-node)))
                (if child-for-desired
                    (loop child-for-desired (- bit-idx 1) (bitwise-ior current-xor (arithmetic-shift 1 bit-idx)))
                    (let ((child-for-same (trie-node-child1 current-node)))
                      (loop child-for-same (- bit-idx 1) current-xor))))
              (let ((child-for-desired (trie-node-child1 current-node)))
                (if child-for-desired
                    (loop child-for-desired (- bit-idx 1) (bitwise-ior current-xor (arithmetic-shift 1 bit-idx)))
                    (let ((child-for-same (trie-node-child0 current-node)))
                      (loop child-for-same (- bit-idx 1) current-xor)))))))))

(define (find-maximum-xor nums)
  (if (null? nums)
      0
      (let ((root (trie-node #f #f)))
        (for-each (lambda (num) (insert-num root num)) nums)

        (define max-xor 0)
        (for-each (lambda (num)
                    (set! max-xor (max max-xor (find-max-xor root num))))
                  nums)
        max-xor)))