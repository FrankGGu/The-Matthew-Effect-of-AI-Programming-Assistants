(define (minPartitions n)
  (apply max (map string->number (string-split n ""))))