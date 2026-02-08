(define (can-redistribute apples capacity)
  (define (sum-list lst)
    (foldl + 0 lst))
  (<= (sum-list apples) (sum-list capacity)))