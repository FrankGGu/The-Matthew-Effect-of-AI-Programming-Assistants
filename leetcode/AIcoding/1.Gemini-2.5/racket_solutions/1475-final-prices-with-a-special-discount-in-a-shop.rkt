(define (final-prices prices)
  (let loop ((remaining-prices prices)
             (acc '()))
    (if (empty? remaining-prices)
        (reverse acc)
        (let* ((current-price (car remaining-prices))
               (subsequent-prices (cdr remaining-prices))
               (discount (find-discount-value subsequent-prices current-price)))
          (loop subsequent-prices
                (cons (- current-price discount) acc))))))

(define (find-discount-value subsequent-prices current-price)
  (if (empty? subsequent-prices)
      0
      (let ((next-price (car subsequent-prices)))
        (if (<= next-price current-price)
            next-price
            (find-discount-value (cdr subsequent-prices) current-price)))))