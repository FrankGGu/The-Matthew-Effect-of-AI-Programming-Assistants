(define/contract (min-deletion-size strs)
  (-> (listof string?) exact-integer?)
  (define n (length strs))
  (if (zero? n)
      0
      (let ([m (string-length (first strs))])
        (for/sum ([j (in-range m)]
                  #:when (for/or ([i (in-range 1 n)])
                            (char>? (string-ref (list-ref strs (sub1 i)) j)
                            (string-ref (list-ref strs i) j)))
         1
         0))))