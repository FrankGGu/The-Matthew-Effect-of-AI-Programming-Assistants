(define (two-sum prices target)
  (let ((price-map (make-hash)))
    (let loop ((idx 0) (remaining-prices prices))
      (let* ((current-price (car remaining-prices))
             (complement (- target current-price)))
        (cond
          ((hash-has-key? price-map complement)
           (list (hash-ref price-map complement) idx))
          (else
           (hash-set! price-map current-price idx)
           (loop (+ 1 idx) (cdr remaining-prices))))))))