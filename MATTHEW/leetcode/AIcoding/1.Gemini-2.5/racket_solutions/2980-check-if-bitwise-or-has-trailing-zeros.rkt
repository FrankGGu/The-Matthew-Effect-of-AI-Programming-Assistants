(define (has-trailing-zeros? nums)
  (let ([or-result (foldl bitwise-ior 0 nums)])
    (even? or-result)))