(define/contract (find-permutation-difference s t)
  (-> string? string? exact-integer?)
  (let ([pos (make-hash)])
    (for ([c (in-string s)]
          [i (in-naturals)])
      (hash-set! pos c i))
    (for/sum ([c (in-string t)]
              [i (in-naturals)])
      (abs (- (hash-ref pos c) i)))))