(define/contract (min-partitions n)
  (-> string? exact-integer?)
  (apply max (map (lambda (c) (- (char->integer c) (char->integer #\0))) (string->list n)))