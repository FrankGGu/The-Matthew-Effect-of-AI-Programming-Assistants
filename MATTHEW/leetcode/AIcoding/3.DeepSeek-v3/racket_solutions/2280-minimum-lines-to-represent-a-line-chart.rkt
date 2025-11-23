(define/contract (minimum-lines stock-prices)
  (-> (listof (listof exact-integer?)) exact-integer?)
  (if (<= (length stock-prices) 2)
      (if (<= (length stock-prices) 1) 0 1)
      (let loop ([points (sort stock-prices (λ (a b) (< (car a) (car b))))]
                 [lines 0]
                 [prev-dx #f]
                 [prev-dy #f])
        (if (null? (cdr points))
            lines
            (let* ([p1 (car points)]
                   [p2 (cadr points)]
                   [dx (- (car p2) (car p1))]
                   [dy (- (cadr p2) (cadr p1))]
              (if (and prev-dx prev-dy (equal? (* prev-dx dy) (* prev-dy dx)))
                  (loop (cdr points) lines prev-dx prev-dy)
                  (loop (cdr points) (add1 lines) dx dy)))))))