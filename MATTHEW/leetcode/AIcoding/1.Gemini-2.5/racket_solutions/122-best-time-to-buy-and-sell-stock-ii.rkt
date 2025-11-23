(define (max-profit prices)
  (if (null? prices)
      0
      (let loop ((profit 0)
                 (prev-price (car prices))
                 (remaining-prices (cdr prices)))
        (if (null? remaining-prices)
            profit
            (let* ((current-price (car remaining-prices))
                   (diff (- current-price prev-price)))
              (loop (+ profit (if (> diff 0) diff 0))
                    current-price
                    (cdr remaining-prices)))))))