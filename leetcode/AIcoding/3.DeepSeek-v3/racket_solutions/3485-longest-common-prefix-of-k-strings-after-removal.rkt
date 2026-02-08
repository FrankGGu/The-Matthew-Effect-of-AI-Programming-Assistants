(define/contract (longest-common-prefix strs k)
  (-> (listof string?) exact-integer? string?)
  (define n (length strs))
  (if (<= n k)
      ""
      (let loop ([len (apply min (map string-length strs))])
        (if (zero? len)
            ""
            (let ([prefix (substring (car strs) 0 len)])
              (if (for/and ([s (in-list (cdr strs))])
                    (string=? prefix (substring s 0 len)))
                  prefix
                  (loop (sub1 len)))))))