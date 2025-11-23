(define (is-alien-sorted words order)
  (let ((order-map (make-hash)))
    (for ([char (in-string order)] [idx (in-naturals)])
      (hash-set! order-map char idx))

    (define (word-less? word1 word2)
      (let* ((len1 (string-length word1))
             (len2 (string-length word2))
             (min-len (min len1 len2)))
        (let loop ((i 0))
          (cond
            ((= i min-len)
             (< len1 len2))
            (else
             (let* ((c1 (string-ref word1 i))
                    (c2 (string-ref word2 i))
                    (idx1 (hash-ref order-map c1))
                    (idx2 (hash-ref order-map c2)))
               (cond
                 ((< idx1 idx2) #t)
                 ((> idx1 idx2) #f)
                 (else (loop (+ i 1))))))))))

    (for/and ([word1 (in-list words)]
              [word2 (in-list (cdr words))])
      (word-less? word1 word2))))