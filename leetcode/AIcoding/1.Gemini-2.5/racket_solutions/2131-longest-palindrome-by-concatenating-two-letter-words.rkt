#lang racket

(require racket/hash)
(require racket/string)

(define (longest-palindrome words)
  (define counts (make-hash))

  ;; Populate counts for each word
  (for ([word words])
    (hash-update! counts word add1 0))

  (define total-length 0)
  (define has-odd-center #f)

  ;; Iterate through the keys of the hash table
  (for ([word (hash-keys counts)])
    (define current-word-count (hash-ref counts word 0))

    ;; Only process words that haven't been fully consumed by a pair
    (when (> current-word-count 0)
      (define reversed-word (string-reverse word))

      (cond
        ;; Case 1: The word is a palindrome itself (e.g., "aa")
        [(string=? word reversed-word)
         ;; Use all even pairs of this word
         (define num-pairs (quotient current-word-count 2))
         (set! total-length (+ total-length (* num-pairs 4)))
         ;; If there's an odd count, one can be used as the center
         (when (odd? current-word-count)
           (set! has-odd-center #t))
         ;; Mark this word as processed
         (hash-set! counts word 0)]

        ;; Case 2: The word is not a palindrome (e.g., "ab")
        [else
         (define reversed-word-count (hash-ref counts reversed-word 0))
         ;; Use as many pairs of (word, reversed-word) as possible
         (define num-matching-pairs (min current-word-count reversed-word-count))
         (set! total-length (+ total-length (* num-matching-pairs 4)))
         ;; Mark both words as processed
         (hash-set! counts word 0)
         (hash-set! counts reversed-word 0)])))

  ;; If a central word (like "aa") was available, add its length
  (when has-odd-center
    (set! total-length (+ total-length 2)))

  total-length)