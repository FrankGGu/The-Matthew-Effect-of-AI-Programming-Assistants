(define (purchase-scheme prices target)
  (let* ([n (length prices)]
         [sorted-prices (sort prices <)]
         [prices-vec (list->vector sorted-prices)])
    (let loop ([left 0]
               [right (- n 1)]
               [count 0])
      (cond
        [(>= left right) count]
        [(<= (* (vector-ref prices-vec left)
                (vector-ref prices-vec right))
             target)
         (loop (+ left 1)
               right
               (+ count (- right left)))]
        [else
         (loop left
               (- right 1)
               count)]))))