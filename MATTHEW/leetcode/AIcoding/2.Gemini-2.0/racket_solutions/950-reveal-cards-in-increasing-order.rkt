(define (deck-revealed-increasing! deck)
  (let* ((n (length deck))
         (index (range n))
         (result (make-vector n)))
    (sort! deck <)
    (let loop ((cards deck) (indices index))
      (cond
        [(null? cards)
         (list->vector (vector->list result))]
        [else
         (vector-set! result (car indices) (car cards))
         (loop (cdr cards) (append (cdr indices) (list (car indices))))]))))