(define (find-town-judge n trust)
  (let ((in-degree (make-vector (+ n 1) 0))
        (out-degree (make-vector (+ n 1) 0)))
    (for-each
     (lambda (pair)
       (vector-set! out-degree (car pair) (+ (vector-ref out-degree (car pair)) 1))
       (vector-set! in-degree (cadr pair) (+ (vector-ref in-degree (cadr pair)) 1)))
     trust)
    (let loop ((i 1))
      (if (> i n)
          -1
          (if (and (= (vector-ref in-degree i) (- n 1)) (= (vector-ref out-degree i) 0))
              i
              (loop (+ i 1)))))))