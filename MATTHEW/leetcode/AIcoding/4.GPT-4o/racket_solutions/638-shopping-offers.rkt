(define (shoppingOffers(price discounts special)) 
  (define (dp needs)
    (if (and (null? needs) (null? (cdr needs))) 0
        (let loop ((needs needs) (min-cost +inf.0))
          (if (null? needs)
              min-cost
              (let ((current-need (car needs)))
                (for-each
                  (lambda (offer)
                    (let ((new-needs (map - needs (take offer (length needs)))))
                      (when (and (every? (lambda (x) (>= x 0)) new-needs))
                        (set! min-cost (min min-cost (+ (apply + (map * price needs)) (dp new-needs)) (apply + (drop offer (length needs))))))))
                  special)
                (loop (cdr needs) min-cost)))))
  (dp (map (lambda (x) x) price))

(shoppingOffers (list 2 5) (list (list 3 0 5) (list 1 2 10)) (list (list 2 2 3)))