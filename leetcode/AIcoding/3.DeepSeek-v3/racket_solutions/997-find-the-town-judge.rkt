(define (find-judge n trust)
  (let* ([in-degree (make-vector n 0)]
         [out-degree (make-vector n 0)])
    (for ([t trust])
      (let ([a (sub1 (first t))]
            [b (sub1 (second t))])
        (vector-set! out-degree a (add1 (vector-ref out-degree a)))
        (vector-set! in-degree b (add1 (vector-ref in-degree b)))))
    (for/first ([i (in-range n)]
                #:when (and (= (vector-ref in-degree i) (sub1 n))
                            (= (vector-ref out-degree i) 0)))
      (add1 i)))