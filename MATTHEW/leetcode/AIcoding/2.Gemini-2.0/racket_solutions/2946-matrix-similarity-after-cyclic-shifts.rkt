(define (areSimilar mat k)
  (let ([m (length mat)]
        [n (length (first mat))])
    (for/and ([i (in-range m)])
      (let ([shifted-row (list-tail (append (list-ref mat i) (list-ref mat i)) (modulo k n))])
        (for/and ([j (in-range n)])
          (equal? (list-ref (list-ref mat i) j) (list-ref shifted-row j)))))))