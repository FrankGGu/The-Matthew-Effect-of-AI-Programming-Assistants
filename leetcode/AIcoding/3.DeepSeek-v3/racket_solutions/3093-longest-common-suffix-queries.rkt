(define (string-indices words)
  (for/hash ([word (in-list words)]
             [i (in-naturals)])
    (values word i)))

(define (longest-common-suffix queries words)
  (let* ([word-indices (string-indices words)]
         [word-suffixes (for/list ([word (in-list words)])
                          (reverse (string->list word)))])
    (for/list ([query (in-list queries)])
      (let ([query-suffix (reverse (string->list query))]
            [max-len -1]
            [min-index (length words)])
        (for ([word-suffix (in-list word-suffixes)]
              [i (in-naturals)])
          (let ([common-len 0])
            (for ([qc (in-list query-suffix)]
                  [wc (in-list word-suffix)]
                  #:break (not (char=? qc wc)))
              (set! common-len (add1 common-len)))
            (when (or (> common-len max-len)
                      (and (= common-len max-len) (< i min-index)))
              (set! max-len common-len)
              (set! min-index i))))
        min-index))))