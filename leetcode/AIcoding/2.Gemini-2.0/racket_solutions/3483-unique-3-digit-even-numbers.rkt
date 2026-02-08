(define (unique-3-digit-even-numbers digits)
  (define (generate-numbers)
    (define result '())
    (for* ([i (in-list digits)]
           [j (in-list digits)]
           [k (in-list digits)]
           #:when (and (not (= i j))
                      (not (= i k))
                      (not (= j k))
                      (not (= i 0))
                      (even? k)))
      (set! result (cons (+ (* 100 i) (* 10 j) k) result)))
    (sort (remove-duplicates result) <))

  (generate-numbers))