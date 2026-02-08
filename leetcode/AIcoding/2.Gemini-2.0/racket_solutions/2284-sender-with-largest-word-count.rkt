(define (most-words-found sentences)
  (let loop ([sentences sentences] [max-words 0])
    (cond
      [(null? sentences) max-words]
      [else (let ([words (string-split (car sentences) " ")])
              (loop (cdr sentences) (max max-words (length words))))])))

(define (sender-with-largest-word-count messages senders)
  (let ([word-counts (make-hash)])
    (for ([i (in-range (length messages))])
      (let ([message (list-ref messages i)]
            [sender (list-ref senders i)])
        (hash-update! word-counts sender (λ (count) (+ count (length (string-split message " ")))) 0)))
    (let ([max-count (apply max (hash-values word-counts))])
      (let ([max-senders (filter (λ (sender) (= (hash-ref word-counts sender) max-count)) (hash-keys word-counts))])
        (list->string (sort max-senders string>?))))))