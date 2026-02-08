(define (most-common-word paragraph banned)
  (let* ([normalized-paragraph (regexp-replace* #rx"[!?',;.]" paragraph " ")]
         [words (string-split normalized-paragraph)]
         [filtered-words (filter (lambda (word) (not (member (string-downcase word) banned))) words)]
         [word-counts (hash)])
    (for ([word filtered-words])
      (let ([lower-word (string-downcase word)])
        (hash-update! word-counts lower-word (lambda (count) (+ count 1)) 0)))
    (let loop ([keys (hash-keys word-counts)] [max-word ""] [max-count 0])
      (cond
        [(null? keys) max-word]
        (else
         (let ([word (car keys)]
               [count (hash-ref word-counts word)])
           (if (> count max-count)
               (loop (cdr keys) word count)
               (loop (cdr keys) max-word max-count))))))))