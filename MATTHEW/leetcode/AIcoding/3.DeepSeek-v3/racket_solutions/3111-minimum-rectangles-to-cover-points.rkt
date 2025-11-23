(define/contract (min-rectangles-to-cover-points points w)
  (-> (listof (listof exact-integer?)) exact-integer? exact-integer?)
  (let loop ([sorted-points (sort points (λ (a b) (< (car a) (car b))))]
             [res 0]
             [start -inf.0])
    (if (null? sorted-points)
        res
        (let* ([current (car sorted-points)]
               [x (car current)]
               [y (cadr current)])
        (if (> x start)
            (loop (cdr sorted-points) (add1 res) (+ x w))
            (loop (cdr sorted-points) res start)))))