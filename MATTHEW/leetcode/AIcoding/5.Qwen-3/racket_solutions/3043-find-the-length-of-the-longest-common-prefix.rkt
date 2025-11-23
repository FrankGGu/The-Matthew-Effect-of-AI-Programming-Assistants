(define (longest-common-prefix strs)
  (if (null? strs)
      ""
      (let loop ([prefix (car strs)] [rest (cdr strs)])
        (if (null? rest)
            prefix
            (let ([new-prefix (take prefix (min (length prefix) (length (car rest))))])
              (if (equal? new-prefix (take (car rest) (length new-prefix)))
                  (loop new-prefix (cdr rest))
                  ""))))))