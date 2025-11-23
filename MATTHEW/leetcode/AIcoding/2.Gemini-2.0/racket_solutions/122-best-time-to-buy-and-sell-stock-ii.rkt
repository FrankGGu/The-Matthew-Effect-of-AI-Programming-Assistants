(define (max-profit prices)
  (let loop ([i 1] [profit 0])
    (cond
      [(>= i (length prices)) profit]
      [(> (list-ref prices i) (list-ref prices (- i 1)))
       (loop (+ i 1) (+ profit (- (list-ref prices i) (list-ref prices (- i 1)))))]
      [else (loop (+ i 1) profit)])))