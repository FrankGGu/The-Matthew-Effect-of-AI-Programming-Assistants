(define (find-judge n trust)
  (let ([in-degree (make-vector (add1 n) 0)]
        [out-degree (make-vector (add1 n) 0)])
    (for ([t trust])
      (vector-set! out-degree (first t) (add1 (vector-ref out-degree (first t))))
      (vector-set! in-degree (second t) (add1 (vector-ref in-degree (second t)))))
    (let loop ([i 1])
      (cond
        [(> i n) -1]
        [(= (vector-ref in-degree i) (sub1 n))
         (if (= (vector-ref out-degree i) 0)
             i
             (loop (add1 i)))]
        [else (loop (add1 i))]))))