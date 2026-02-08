(define/contract (erase-overlap-intervals intervals)
  (-> (listof (listof exact-integer?)) exact-integer?)
  (if (null? intervals)
      0
      (let* ([sorted-intervals (sort intervals (lambda (a b) (< (second a) (second b))))]
             [count 1]
             [end (second (first sorted-intervals))])
        (for ([interval (rest sorted-intervals)])
          (when (>= (first interval) end)
            (set! count (+ count 1))
            (set! end (second interval))))
        (- (length intervals) count))))