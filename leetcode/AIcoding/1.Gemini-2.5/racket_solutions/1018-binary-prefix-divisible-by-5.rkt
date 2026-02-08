(define (prefixes-div-by-5 nums)
  (reverse
   (second
    (for/fold ([current-val-mod-5 0] [result '()])
              ([bit (in-list nums)])
      (let ([new-val-mod-5 (modulo (+ (* current-val-mod-5 2) bit) 5)])
        (values new-val-mod-5 (cons (= new-val-mod-5 0) result)))))))