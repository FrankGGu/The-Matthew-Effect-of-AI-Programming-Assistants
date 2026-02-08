(define (max-energy-boost drinks)
  (let* ((sorted-drinks (sort drinks >))
         (a (car sorted-drinks))
         (b (cadr sorted-drinks)))
    (cond
      [(and (> a 0) (> b 0)) (- (+ a b) 2)]
      [else 0])))