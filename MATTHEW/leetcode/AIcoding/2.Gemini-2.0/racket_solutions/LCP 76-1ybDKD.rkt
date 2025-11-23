(define (solve-magic-board n m ops)
  (define (apply-op board op)
    (match op
      [(list 1 x)
       (for/list ([i (in-range m)])
         (list-set board x i (not (list-ref (list-ref board x) i))))]
      [(list 2 y)
       (for/list ([i (in-range n)])
         (list-set (list-ref board i) y (not (list-ref (list-ref board i) y)))
         (list-ref board i))]
      [_ board]))

  (define initial-board (make-list n (make-list m #f)))
  (foldl apply-op initial-board ops))

(define (magic-board n m ops)
  (solve-magic-board n m ops))