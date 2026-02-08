(define (minimum-card-pickup cards)
  (define indices (make-hash))
  (define min-length +inf.0)

  (for ([i (in-range (length cards))])
    (let ([card (list-ref cards i)])
      (if (hash-has-key? indices card)
          (let ([prev-index (hash-ref indices card)])
            (set! min-length (min min-length (- i prev-index 1))))
          (hash-set! indices card i))))

  (if (= min-length +inf.0) -1 min-length))