(define (min-operations nums k)
  (let* ([sorted-nums (sort nums <)]
         [n (length sorted-nums)]
         [median-pos (quotient n 2)]
         [median (list-ref sorted-nums median-pos)]
         [operations 0])
    (cond
      [(= median k) 0]
      [(< median k)
       (for ([i (in-range median-pos n)])
         (when (< (list-ref sorted-nums i) k)
           (set! operations (+ operations (- k (list-ref sorted-nums i))))))
       operations]
      [else
       (for ([i (in-range (add1 median-pos))])
         (when (> (list-ref sorted-nums i) k)
           (set! operations (+ operations (- (list-ref sorted-nums i) k)))))
       operations])))