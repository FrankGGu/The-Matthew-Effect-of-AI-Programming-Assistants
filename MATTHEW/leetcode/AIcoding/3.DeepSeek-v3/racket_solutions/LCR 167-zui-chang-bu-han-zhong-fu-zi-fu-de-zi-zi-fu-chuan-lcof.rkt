(define/contract (first-uniq-char s)
  (-> string? exact-integer?)
  (let ([count (make-hash)])
    (for ([char (in-string s)])
      (hash-update! count char add1 0))
    (for/first ([char (in-string s)]
                [i (in-naturals)]
                #:when (= (hash-ref count char) 1))
      i)
    -1))