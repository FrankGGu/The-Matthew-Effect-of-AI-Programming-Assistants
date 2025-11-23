(define (most-common-word paragraph banned)
  ;; Convert paragraph to lowercase and replace non-alphabetic characters with spaces
  (define lower-paragraph (string-downcase paragraph))
  (define cleaned-paragraph (regexp-replace* #rx"[^a-z]" lower-paragraph " "))

  ;; Split the cleaned paragraph into words
  ;; string-split with a single space as delimiter handles multiple spaces correctly
  (define words (string-split cleaned-paragraph " "))

  ;; Create a hash set for banned words for efficient lookup
  (define banned-set (list->hash (map (lambda (w) (cons w #t)) banned)))

  ;; Hash table to store word frequencies
  (define word-counts (make-hash))

  ;; Iterate through words, filter out empty strings and banned words, then count frequencies
  (for ([word words])
    (when (and (not (string-empty? word))
               (not (hash-has-key? banned-set word)))
      (hash-update! word-counts word add1 0)))

  ;; Find the word with the maximum frequency
  (define max-count 0)
  (define result "")

  (hash-for-each word-counts
                 (lambda (word count)
                   (when (> count max-count)
                     (set! max-count count)
                     (set! result word))))

  result)