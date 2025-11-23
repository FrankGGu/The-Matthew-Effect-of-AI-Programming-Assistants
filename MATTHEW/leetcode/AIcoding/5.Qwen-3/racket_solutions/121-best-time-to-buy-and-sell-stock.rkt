(define (max-profit prices)
  (define (helper min-price max-profit)
    (cond [(null? prices) max-profit]
          [else
           (let ([current-price (car prices)])
             (helper (min current-price min-price)
                     (max max-profit (- current-price min-price))))]))
  (helper (car prices) 0))