(define (shopping-offers price special needs)
  (define (calc-price needs)
    (apply + (map * price needs)))

  (define (valid-offer? offer needs)
    (andmap (lambda (offer-need need) (<= offer-need need)) offer needs))

  (define (apply-offer offer needs)
    (map - needs (drop-right offer 1)))

  (define (min-price needs)
    (let loop ((offers special) (min-p (calc-price needs)))
      (cond
        ((null? offers) min-p)
        (else
         (let ((offer (car offers)))
           (if (valid-offer? offer needs)
               (let ((new-needs (apply-offer offer needs))
                     (new-min-p (+ (last offer) (min-price new-needs))))
                 (loop (cdr offers) (min min-p new-min-p)))
               (loop (cdr offers) min-p)))))))
  (min-price needs))