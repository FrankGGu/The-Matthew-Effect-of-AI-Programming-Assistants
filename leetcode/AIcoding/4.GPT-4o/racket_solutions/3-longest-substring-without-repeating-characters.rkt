(define (lengthOfLongestSubstring s)
  (define (helper s start max-length char-index)
    (if (null? s)
        max-length
        (let* ((current-char (car s))
               (index (hash-ref char-index current-char #f))
               (new-start (if (and index (>= index start)) (+ index 1) start)))
          (helper (cdr s) new-start (max max-length (- (length s) new-start)) (hash-set char-index current-char (length s))))))
  (helper (string->list s) 0 0 (hash)))