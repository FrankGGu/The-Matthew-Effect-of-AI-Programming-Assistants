(define (longest-palindrome s)
  (let* ([char-counts (make-hash)]
         [len (string-length s)])
    (unless (zero? len)
      (for ([i (in-range len)])
        (let* ([char (string-ref s i)]
               [current-count (hash-ref char-counts char 0)])
          (hash-set! char-counts char (+ current-count 1)))))

    (let ([total-length 0]
          [has-odd-count #f])
      (hash-for-each
       char-counts
       (lambda (char count)
         (set! total-length (+ total-length (* 2 (quotient count 2))))
         (when (odd? count)
           (set! has-odd-count #t))))

      (if has-odd-count
          (+ total-length 1)
          total-length))))