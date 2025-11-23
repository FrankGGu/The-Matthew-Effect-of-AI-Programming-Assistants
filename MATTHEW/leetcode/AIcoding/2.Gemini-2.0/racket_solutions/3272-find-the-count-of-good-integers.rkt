(define (count-good-integers n)
  (define memo (make-hash))

  (define (dp idx is-tight prev-digit)
    (cond
      [(equal? idx (string-length (number->string n))) 1]
      [(hash-has-key? memo (list idx is-tight prev-digit)) (hash-ref memo (list idx is-tight prev-digit))]
      [else
       (define limit (if is-tight (string->number (substring (number->string n) idx (+ idx 1))) 9))
       (define res 0)
       (for ([i (in-range 0 (+ limit 1))])
         (if (or (equal? prev-digit -1) (not (equal? (abs (- i prev-digit)) 1)))
             (set! res (+ res (dp (+ idx 1) (and is-tight (equal? i limit)) i)))))
       (hash-set! memo (list idx is-tight prev-digit) res)
       res]))

  (dp 0 #t -1))