(define/contract (minimum-card-pickup cards)
  (-> (listof exact-integer?) exact-integer?)
  (let ([pos (make-hash)]
        [min-dist +inf.0])
    (for ([(card i) (in-indexed cards)])
      (when (hash-has-key? pos card)
        (set! min-dist (min min-dist (- i (hash-ref pos card)))))
      (hash-set! pos card i))
    (if (equal? min-dist +inf.0) -1 (add1 min-dist))))