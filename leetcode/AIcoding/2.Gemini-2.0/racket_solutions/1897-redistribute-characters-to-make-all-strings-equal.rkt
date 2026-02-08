(define (make-equal words)
  (let* ((n (length words))
         (total-length (foldl + 0 (map string-length words)))
         (counts (make-hash)))
    (if (zero? n)
        #t
        (begin
          (for* ((word (in-list words))
                 (char (in-string word)))
            (hash-update! counts char (λ (v) (+ v 1)) 1))
          (for* ((k (in-list (hash-keys counts))))
            (if (not (zero? (modulo (hash-ref counts k) n)))
                (return #f)))
          #t))))