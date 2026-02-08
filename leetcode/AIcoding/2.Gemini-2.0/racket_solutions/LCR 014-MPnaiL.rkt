(define (check-inclusion s1 s2)
  (define (char-count s)
    (let ((counts (make-hash)))
      (for ([c (string->list s)])
        (hash-update! counts c (λ (v) (+ v 1)) 1))
      counts))

  (define s1-counts (char-count s1))
  (define len1 (string-length s1))
  (define len2 (string-length s2))

  (if (> len1 len2)
      #f
      (let loop ([i 0])
        (cond
          [(>= i (- len2 len1 -1)) #f]
          [else
           (let ((sub-s2 (substring s2 i (+ i len1))))
             (if (equal? s1-counts (char-count sub-s2))
                 #t
                 (loop (+ i 1))))]))))