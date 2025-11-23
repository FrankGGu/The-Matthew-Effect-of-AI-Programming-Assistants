(define (smallest-palindromic-rearrangement s)
  (define counts (make-hash))
  (for ([c (string->list s)])
    (hash-update! counts c (λ (v) (+ v 1)) 1))
  (define odd-chars (filter (λ (c) (odd? (hash-ref counts c))) (hash-keys counts)))
  (if (> (length odd-chars) 1)
      ""
      (let* ([even-chars (filter (λ (c) (even? (hash-ref counts c 0))) (hash-keys counts))]
             [half-string (list->string (append (sort (append (map (λ (c) (make-list (/ (hash-ref counts c) 2) c)) even-chars) (if (null? odd-chars) '() (list (make-list (/ (hash-ref counts (car odd-chars)) 2) (car odd-chars))))) char<?) char->integer))]
             [middle-char (if (null? odd-chars) "" (string (list (car odd-chars))))])
        (string-append half-string middle-char (string-reverse half-string))))))