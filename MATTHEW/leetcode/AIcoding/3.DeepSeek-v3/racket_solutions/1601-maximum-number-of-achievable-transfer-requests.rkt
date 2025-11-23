(define (maximum-requests n requests)
  (define max-count 0)
  (define len (length requests))

  (define (backtrack index count balance)
    (when (= index len)
      (when (andmap zero? balance)
        (set! max-count (max max-count count)))
      (void))

    (when (< index len)
      (let* ([req (list-ref requests index)]
             [from (first req)]
             [to (second req)]
             [new-balance (list->vector (vector->list balance))])
        (vector-set! new-balance from (sub1 (vector-ref new-balance from)))
        (vector-set! new-balance to (add1 (vector-ref new-balance to)))
        (backtrack (add1 index) (add1 count) new-balance)
        (backtrack (add1 index) count balance))))

  (backtrack 0 0 (make-vector n 0))
  max-count)