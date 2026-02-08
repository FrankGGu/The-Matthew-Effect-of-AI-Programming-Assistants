(define (maximum-importance n roads)
  (let* ([degrees (make-vector n 0)]
         [sorted-nodes '()])
    (for ([road roads])
      (let ([a (first road)]
            [b (second road)])
        (vector-set! degrees a (+ (vector-ref degrees a) 1))
        (vector-set! degrees b (+ (vector-ref degrees b) 1))))
    (set! sorted-nodes (sort (range n) > #:key (lambda (x) (vector-ref degrees x))))
    (let ([value n]
          [importance (make-hash)]
          [total 0])
      (for ([node sorted-nodes])
        (hash-set! importance node value)
        (set! value (- value 1)))
      (for ([road roads])
        (let ([a (first road)]
              [b (second road)])
          (set! total (+ total (hash-ref importance a) (hash-ref importance b)))))
      total)))