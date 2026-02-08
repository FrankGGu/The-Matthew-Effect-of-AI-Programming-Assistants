(define (flip-game-hashmap f)
  (let* ((card-positions (make-hash)))
    (for-each (lambda (card)
                (hash-set! card-positions card #t))
              f)
    (let loop ((cards (hash->list card-positions))
               (min-sum #f))
      (if (null? cards)
          (if min-sum
              min-sum
              1)
          (let* ((current (car cards))
                 (next-min-sum (if (or (not min-sum)
                                        (< (string->number current) (string->number min-sum)))
                                   current
                                   min-sum)))
            (loop (cdr cards) next-min-sum))))))

(define (flip-game cards)
  (let ((result (flip-game-hashmap cards)))
    (if (eq? result 1)
        0
        (string->number result))))