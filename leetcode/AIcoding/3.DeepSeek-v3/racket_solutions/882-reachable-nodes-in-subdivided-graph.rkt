(define/contract (reachable-nodes edges max-moves n)
  (-> (listof (listof exact-integer?)) exact-integer? exact-integer? exact-integer?)
  (let* ([graph (make-hash)]
         [dist (make-vector n +inf.0)]
         [heap (make-heap (lambda (a b) (< (car a) (car b))))]
    (vector-set! dist 0 0)
    (heap-add! heap (cons 0 0))
    (for ([edge edges])
      (let ([u (first edge)]
            [v (second edge)]
            [w (third edge)])
        (hash-update! graph u (lambda (lst) (cons (cons v w) lst)) '())
        (hash-update! graph v (lambda (lst) (cons (cons u w) lst)) '())))
    (let loop ()
      (unless (heap-empty? heap)
        (let* ([current (heap-remove! heap)]
               [d (car current)]
               [u (cdr current)])
          (when (<= d (vector-ref dist u))
            (for ([neighbor (hash-ref graph u '())])
              (let* ([v (car neighbor)]
                     [w (cdr neighbor)]
                     [new-dist (+ d w 1)])
                (when (< new-dist (vector-ref dist v))
                  (vector-set! dist v new-dist)
                  (heap-add! heap (cons new-dist v))))))
          (loop))))
    (let ([res 0])
      (for ([d dist] #:when (<= d max-moves))
        (set! res (add1 res)))
      (for ([edge edges])
        (let ([u (first edge)]
              [v (second edge)]
              [w (third edge)])
          (let ([a (max (- max-moves (vector-ref dist u)) 0)]
                [b (max (- max-moves (vector-ref dist v)) 0)])
            (set! res (+ res (min (+ a b) w))))))
      res)))