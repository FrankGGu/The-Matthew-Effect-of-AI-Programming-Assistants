(define (predictPartyVictory senate)
  (define (simulate senate)
    (let loop ((senate senate)
               (r 0)
               (d 0))
      (cond
        [(null? senate) (if (zero? r) "Dire" "Radiant")]
        [(equal? (car senate) #\R) (loop (cdr senate) (+ r 1) d)]
        [(equal? (car senate) #\D) (loop (cdr senate) r (+ d 1))]
        [(> r d) (loop (cdr senate) (- r 1) d)]
        [else (loop (cdr senate) r (- d 1))])))
  (simulate (string->list senate)))