#lang racket

(define (groups-of-strings words)
  (define mask-to-count (make-hash))

  ;; Step 1: Convert each word to its bitmask and count occurrences of each mask.
  (for-each (lambda (word)
              (define mask 0)
              (for-each (lambda (char)
                          (set! mask (bitwise-ior mask (arithmetic-shift 1 (- (char->integer char) (char->integer #\a))))))
                        (string->list word))
              (hash-update! mask-to-count mask add1 0))
            words)

  (define parent (make-hash))
  (define sz (make-hash))

  ;; DSU find operation with path compression
  (define (find m)
    (cond
      ((eq? (hash-ref parent m) m) m)
      (else
       (define root (find (hash-ref parent m)))
       (hash-set! parent m root)
       root)))

  ;; DSU union operation by size
  (define (union m1 m2)
    (define root1 (find m1))
    (define root2 (find m2))
    (unless (eq? root1 root2)
      (hash-set! parent root2 root1)
      (hash-update! sz root1 (lambda (v) (+ v (hash-ref sz root2))) 0)
      #t)
    #f)

  ;; Step 2: Initialize DSU for all unique masks
  (for-each (lambda (mask)
              (hash-set! parent mask mask)
              (hash-set! sz mask (hash-ref mask-to-count mask)))
            (hash-keys mask-to-count))

  ;; Step 3: Process connections between masks
  (for-each (lambda (mask)
              ;; Type 1: Add or delete one character
              ;; This means flipping exactly one bit in the mask.
              (for i (in-range 26)
                (define neighbor-mask (bitwise-xor mask (arithmetic-shift 1 i)))
                (when (hash-has-key? mask-to-count neighbor-mask)
                  (union mask neighbor-mask)))

              ;; Type 2: Change one character
              ;; This means removing one character (bit i) and adding another (bit j).
              ;; So, bit i must be set, bit j must be unset.
              (for i (in-range 26) ; Character to remove (bit i must be 1)
                (when (not (zero? (bitwise-and mask (arithmetic-shift 1 i))))
                  (for j (in-range 26) ; Character to add (bit j must be 0)
                    (when (zero? (bitwise-and mask (arithmetic-shift 1 j)))
                      (define neighbor-mask (bitwise-ior (bitwise-xor mask (arithmetic-shift 1 i))
                                                         (arithmetic-shift 1 j)))
                      (when (hash-has-key? mask-to-count neighbor-mask)
                        (union mask neighbor-mask)))))))
            (hash-keys mask-to-count))

  ;; Step 4: Count groups and find the largest group size
  (define num-groups 0)
  (define max-group-size 0)

  (for-each (lambda (mask)
              (when (eq? (hash-ref parent mask) mask) ; If mask is a root of a component
                (set! num-groups (add1 num-groups))
                (set! max-group-size (max max-group-size (hash-ref sz mask)))))
            (hash-keys mask-to-count))

  (list num-groups max-group-size))