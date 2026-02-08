(define (maximum-spending prices)
  (let* ([all-items (append-map identity prices)]
         [sorted-items (sort all-items <)])
    (for/sum ([price (in-list sorted-items)]
              [day (in-naturals 1)])
      (* price day))))