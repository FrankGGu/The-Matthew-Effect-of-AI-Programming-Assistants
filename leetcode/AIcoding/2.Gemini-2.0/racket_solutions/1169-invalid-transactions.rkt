(define (invalid-transactions transactions)
  (define ts (map (lambda (t)
                     (let ([parts (string-split t ",")])
                       (list (car parts)
                             (string->number (cadr parts))
                             (string->number (caddr parts))
                             (car (cdddr parts))
                             t)))
                   transactions))
  (define (is-invalid? t ts)
    (let* ([name (car t)]
           [time (cadr t)]
           [amount (caddr t)]
           [city (cadddr t)]
           [original-transaction (caddddr t)])
      (or (> amount 1000)
          (ormap (lambda (other-t)
                    (let ([other-name (car other-t)]
                          [other-time (cadr other-t)]
                          [other-city (cadddr other-t)]
                          [other-original-transaction (caddddr other-t)])
                      (and (equal? name other-name)
                           (not (equal? city other-city))
                           (<= (abs (- time other-time)) 60)
                           (not (equal? original-transaction other-original-transaction)))))
                 ts))))
  (filter (lambda (t) (is-invalid? t ts))
          (map (lambda (t) (caddddr t)) ts)))