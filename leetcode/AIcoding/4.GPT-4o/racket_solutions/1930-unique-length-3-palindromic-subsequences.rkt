(define (count-palindromic-subsequences s)
  (define n (string-length s))
  (define result (make-hash))

  (for ([i (in-range n)])
    (for ([j (in-range (add1 i) n)])
      (if (char=? (string-ref s i) (string-ref s j))
          (let ([char (string-ref s i)])
            (for ([k (in-range n)])
              (when (and (not (= k i)) (not (= k j)) (char=? (string-ref s k) char))
                (hash-set! result (list char (string-ref s i) (string-ref s j)) #t)))))))

  (hash-count result))

(count-palindromic-subsequences "bccb")