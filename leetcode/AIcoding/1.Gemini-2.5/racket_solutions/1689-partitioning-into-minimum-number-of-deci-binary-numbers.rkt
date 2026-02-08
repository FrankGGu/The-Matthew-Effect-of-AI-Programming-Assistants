(define (min-partitions n)
  (let* ([chars (string->list n)]
         [digits (map (lambda (c) (- (char->integer c) (char->integer #\0))) chars)])
    (apply max digits)))