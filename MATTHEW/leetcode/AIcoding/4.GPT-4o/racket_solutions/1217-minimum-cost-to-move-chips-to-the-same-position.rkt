(define (minCostToMoveChips chips)
  (define odd-count (length (filter odd? chips)))
  (define even-count (length (filter even? chips)))
  (min odd-count even-count))