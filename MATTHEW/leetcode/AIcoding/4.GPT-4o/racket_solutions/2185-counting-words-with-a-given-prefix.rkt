(define (count-words-with-prefix words prefix)
  (define (word-prefix? word)
    (string-prefix? prefix word))
  (length (filter word-prefix? words)))

(count-words-with-prefix '("apple" "app" "apricot" "banana") "app")