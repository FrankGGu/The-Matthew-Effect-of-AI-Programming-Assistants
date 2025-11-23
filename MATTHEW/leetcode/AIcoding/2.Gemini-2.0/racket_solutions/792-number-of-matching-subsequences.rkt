(define (num-matching-subsequences s words)
  (define (is-subsequence? word s)
    (define (helper word-idx s-idx)
      (cond
        [(>= word-idx (string-length word)) #t]
        [(>= s-idx (string-length s)) #f]
        [else (if (char=? (string-ref word word-idx) (string-ref s s-idx))
                  (helper (+ word-idx 1) (+ s-idx 1))
                  (helper word-idx (+ s-idx 1)))]))
    (helper 0 0))

  (length (filter (lambda (word) (is-subsequence? word s)) words)))