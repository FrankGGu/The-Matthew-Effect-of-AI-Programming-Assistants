(define (digit-game num)
  (let ([digits (string->list (number->string num))])
    (let loop ([digits digits] [player 1])
      (cond
        [(null? digits) (zero? player)]
        [(null? (cdr digits)) (odd? player)]
        [else
         (let ([first-digit (car digits)]
               [last-digit (last digits)])
           (if (or (char>? first-digit last-digit)
                   (and (char=? first-digit last-digit)
                        (not (loop (cdr (reverse (cdr (reverse digits)))))))
               (loop (cdr digits) (- 1 player))
               (loop (reverse (cdr (reverse digits))) (- 1 player))))]))))