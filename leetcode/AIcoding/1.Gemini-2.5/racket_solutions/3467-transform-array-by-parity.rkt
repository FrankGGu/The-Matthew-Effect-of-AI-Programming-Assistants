(define (sort-array-by-parity nums)
  (let* ((evens (filter even? nums))
         (odds (filter odd? nums)))
    (append evens odds)))