(define (shortestCompletingWord licensePlate words)
  (define (char-count str)
    (foldl (lambda (c acc)
              (if (char>=? (char-downcase c) #\a)
                  (hash-update! acc (char-downcase c) (lambda (x) (+ 1 x)) 1)
                  acc))
            (make-hash) str))

  (define license-count (char-count licensePlate))

  (define (completes? word)
    (define word-count (char-count word))
    (for/fold ([result #t]) ([key (hash-keys license-count)])
      (if (<= (hash-ref word-count key 0) (hash-ref license-count key 0))
          result
          #f)))

  (define valid-words (filter completes? words))

  (define (shortest-word words)
    (foldl (lambda (w1 w2) (if (< (string-length w1) (string-length w2)) w1 w2))
           (first words) words))

  (if (null? valid-words)
      ""
      (shortest-word valid-words)))