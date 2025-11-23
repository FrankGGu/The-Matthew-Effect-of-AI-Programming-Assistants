(define (di-string-match s)
  (let* ([n (string-length s)]
         [lo 0]
         [hi n]
         [result (make-vector (add1 n))])
    (for/list ([i (in-range (add1 n))])
      (vector-set! result i
                   (cond
                     [(= i n) lo]
                     [(char=? (string-ref s i) #\I)
                      (let ([temp lo])
                        (set! lo (add1 lo))
                        temp)]
                     [else
                      (let ([temp hi])
                        (set! hi (sub1 hi))
                        temp)])))
    (vector->list result)))