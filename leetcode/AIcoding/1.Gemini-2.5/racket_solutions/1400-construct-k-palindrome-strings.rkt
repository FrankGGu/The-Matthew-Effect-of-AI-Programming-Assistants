(define (can-construct s k)
  (let* ((n (string-length s)))
    (if (> k n)
        #f
        (let ((char-counts (make-hash)))
          (for ([char (in-string s)])
            (hash-update! char-counts char add1 0))

          (define odd-freq-count
            (for/sum ([freq (hash-values char-counts)])
              (if (odd? freq) 1 0)))

          (<= odd-freq-count k))))))