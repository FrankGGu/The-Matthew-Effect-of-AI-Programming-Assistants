(define/contract (longest-common-prefix strs)
  (-> (listof string?) exact-integer?)
  (if (null? strs)
      0
      (let loop ([i 0])
        (if (>= i (string-length (car strs)))
            i
            (let ([c (string-ref (car strs) i)])
              (if (for/and ([s (in-list (cdr strs))])
                    (and (< i (string-length s))
                         (char=? (string-ref s i) c)))
                  (loop (add1 i))
                  i))))))