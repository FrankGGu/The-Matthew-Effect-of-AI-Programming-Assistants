(define (finalPrices prices)
  (define n (length prices))
  (define result (make-vector n 0))
  (for ([i (in-range n)])
    (let ([current-price (vector-ref prices i)])
      (define discounted-price (foldl (lambda (j acc)
                                          (if (and (< j i) 
                                                   (> (vector-ref prices j) current-price))
                                              current-price
                                              acc))
                                        current-price
                                        (in-range i))))
      (vector-set! result i (- current-price discounted-price))))
  (vector->list result))

(finalPrices '(8 4 6 2 3))