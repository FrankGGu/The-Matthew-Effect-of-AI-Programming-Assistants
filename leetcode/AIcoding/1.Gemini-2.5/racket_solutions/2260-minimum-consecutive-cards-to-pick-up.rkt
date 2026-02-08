(define (minimum-consecutive-cards-to-pick-up cards)
  (let* ([n (vector-length cards)]
         [last-seen (make-hash)]
         [min-len (add1 n)])
    (for ([i (in-range n)])
      (let ([card (vector-ref cards i)])
        (when (hash-has-key? last-seen card)
          (let ([prev-idx (hash-ref last-seen card)])
            (set! min-len (min min-len (+ (- i prev-idx) 1))))))
        (hash-set! last-seen card i)))
    (if (= min-len (add1 n))
        -1
        min-len)))