(define (minimumLengthEncoding words)
  (define suffixes (map (lambda (w) (string-drop w 1)) words))
  (define unique-words (remove-duplicates words))
  (define encodable-words (filter (lambda (w) (not (member w suffixes))) unique-words))
  (define total-length (apply + (map (lambda (w) (+ (string-length w) 1)) encodable-words)))
  total-length)

(minimumLengthEncoding '("time" "me" "bell"))