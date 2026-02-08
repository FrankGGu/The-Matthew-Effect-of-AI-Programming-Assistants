(define/contract (circular-game-losers n k)
  (-> exact-integer? exact-integer? (listof exact-integer?))
  (let loop ([current 1]
             [visited (make-hash)]
             [step 1])
    (hash-set! visited current #t)
    (let ([next (modulo (+ current (* step k)) n)])
      (if (hash-has-key? visited next)
          (let ([losers '()])
            (for ([i (in-range 1 (add1 n))])
              (unless (hash-has-key? visited i)
                (set! losers (cons i losers))))
            (reverse losers))
          (loop next visited (add1 step))))))