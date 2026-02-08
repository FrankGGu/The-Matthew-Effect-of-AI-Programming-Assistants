(define (kth-smallest matrix k)
  (let* ([flat-list (apply append matrix)]
         [sorted-list (sort flat-list <)])
    (list-ref sorted-list (- k 1))))