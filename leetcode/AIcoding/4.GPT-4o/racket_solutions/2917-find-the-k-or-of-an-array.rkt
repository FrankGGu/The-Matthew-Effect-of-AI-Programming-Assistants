(define (k-or arr k)
  (foldl (λ (x acc) (bitwise-ior acc x)) 0 (take arr k)))