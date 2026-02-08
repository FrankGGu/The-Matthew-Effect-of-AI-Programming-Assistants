(define/contract (find-lus-length a b)
  (-> string? string? exact-integer?)
  (if (string=? a b)
      -1
      (max (string-length a) (string-length b))))