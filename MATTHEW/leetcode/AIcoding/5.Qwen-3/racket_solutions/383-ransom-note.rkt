#lang racket

(define (can-construct ransom-note magazine)
  (define (count-chars str)
    (for/fold ([counts (hash)]) ([c (in-string str)])
      (hash-update counts c add1 0)))
  (define note-counts (count-chars ransom-note))
  (define mag-counts (count-chars magazine))
  (for/and ([k (hash-keys note-counts)])
    (<= (hash-ref note-counts k) (hash-ref mag-counts k))))