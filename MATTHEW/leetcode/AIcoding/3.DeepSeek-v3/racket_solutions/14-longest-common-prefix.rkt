(define/contract (longest-common-prefix strs)
  (-> (listof string?) string?)
  (if (null? strs)
      ""
      (let loop ([prefix (car strs)] [rest (cdr strs)])
        (if (null? rest)
            prefix
            (let ([min-len (min (string-length prefix) (string-length (car rest)))])
              (let ([new-prefix (for/fold ([acc ""])
                                         ([i (in-range min-len)]
                                          #:break (not (char=? (string-ref prefix i) (string-ref (car rest) i))))
                                 (string-append acc (string (string-ref prefix i))))])
                (if (string=? new-prefix "")
                    ""
                    (loop new-prefix (cdr rest)))))))))