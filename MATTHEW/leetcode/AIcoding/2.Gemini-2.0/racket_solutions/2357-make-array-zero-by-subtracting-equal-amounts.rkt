(define (minimum-operations nums)
  (length (remove-duplicates (remove 0 nums))))