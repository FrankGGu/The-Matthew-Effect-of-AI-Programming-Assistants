(define (valid-anagram s t)
  (define (char-counts str)
    (define counts (make-hash))
    (for ([c (string->list str)])
      (hash-update! counts c (λ (k v) (+ v 1)) 1))
    counts)

  (equal? (char-counts s) (char-counts t)))