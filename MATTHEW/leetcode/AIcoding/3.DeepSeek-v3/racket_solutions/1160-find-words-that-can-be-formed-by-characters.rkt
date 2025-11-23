(define/contract (count-characters words chars)
  (-> (listof string?) string? exact-integer?)
  (let* ([char-count (make-hash)]
         [chars-list (string->list chars)]
         [total 0])
    (for ([c chars-list])
      (hash-update! char-count c add1 0))
    (for ([word words])
      (let ([temp-count (hash-copy char-count)]
            [valid #t])
        (for ([c (string->list word)])
          (when (or (not (hash-has-key? temp-count c))
                (<= (hash-ref temp-count c) 0))
            (set! valid #f)
            (break))
          (when valid
            (hash-update! temp-count c sub1)
            (set! total (+ total (string-length word))))))
    total))