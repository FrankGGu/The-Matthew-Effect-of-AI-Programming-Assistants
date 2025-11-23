(define (min-count coins)
  (define (helper coins count)
    (if (null? coins)
        count
        (helper (cdr coins) (+ count (quotient (car coins) 2) (if (odd? (car coins)) 1 0)))))
  (helper coins 0))