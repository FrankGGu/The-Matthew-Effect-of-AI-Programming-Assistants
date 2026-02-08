(define/contract (longest-subsequence arr difference)
  (-> (listof exact-integer?) exact-integer? exact-integer?)
  (let ([dp (make-hash)]
        [max-len 0])
    (for ([num arr])
      (let ([prev (- num difference)])
      (hash-set! dp num (+ 1 (hash-ref dp prev 0)))
      (set! max-len (max max-len (hash-ref dp num 0))))
    max-len))