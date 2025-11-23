(define (find-town-judge N trust)
  (let* ([in-degrees (make-vector (+ N 1) 0)]
         [out-degrees (make-vector (+ N 1) 0)])
    (for-each (lambda (pair)
                (let ([a (car pair)]
                      [b (cadr pair)])
                  (vector-set! out-degrees a (+ (vector-ref out-degrees a) 1))
                  (vector-set! in-degrees b (+ (vector-ref in-degrees b) 1))))
              trust)
    (let loop ([i 1])
      (cond
        [(> i N) -1]
        [(and (= (vector-ref out-degrees i) 0)
              (= (vector-ref in-degrees i) (- N 1)))
         i]
        [else (loop (+ i 1))])))
)