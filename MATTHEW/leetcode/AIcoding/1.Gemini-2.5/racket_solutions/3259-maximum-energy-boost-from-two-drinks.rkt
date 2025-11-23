(define (maximum-energy-boost drinks)
  (let* ((sorted-drinks (sort drinks >)))
    (+ (car sorted-drinks) (cadr sorted-drinks))))