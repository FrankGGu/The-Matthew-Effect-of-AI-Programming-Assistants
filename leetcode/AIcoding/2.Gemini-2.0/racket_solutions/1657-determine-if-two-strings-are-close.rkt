(define (close-strings s1 s2)
  (define (char-counts s)
    (define counts (make-hash))
    (for ([c (string->list s)])
      (hash-update! counts c (λ (v) (+ v 1)) 1))
    counts)

  (define counts1 (char-counts s1))
  (define counts2 (char-counts s2))

  (and (equal? (sort (hash-keys counts1) char<?) (sort (hash-keys counts2) char<?))
       (equal? (sort (hash-values counts1) <) (sort (hash-values counts2) <))))
)