(define/contract (first-uniq-char s)
  (-> string? exact-integer?)
  (let ([counts (make-hash)])
    (for ([c s])
      (hash-set! counts c (add1 (hash-ref counts c 0))))
    (for/first ([(c i) (in-indexed s)]
                #:when (= (hash-ref counts c) 1))
      i)
    -1))