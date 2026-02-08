(define (number-of-weeks ratings k)
  (let* ([n (length ratings)]
         [dp (make-vector n 1)])
    (for ([i (in-range 1 n)])
      (when (>= (vector-ref ratings i) (vector-ref ratings (- i 1)))
        (vector-set! dp i (+ 1 (vector-ref dp (- i 1))))))
    (let loop ([i (- n 1)] [res 0])
      (cond
        [(< i 0) res]
        [else (let* ([len (vector-ref dp i)])
                (if (>= len k)
                    (loop (- i 1) (+ res (- len k) 1))
                    (loop (- i 1) res))))])))