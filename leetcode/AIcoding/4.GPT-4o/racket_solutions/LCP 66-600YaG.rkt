(define (minNumberOfBooths A)
  (define n (length A))
  (define counts (make-vector 26 0))
  (for ([char A])
    (define idx (- (char->integer char) (char->integer #\a)))
    (vector-set! counts idx (add1 (vector-ref counts idx))))
  (apply max (vector->list counts)))

(minNumberOfBooths "aab") ; Example usage