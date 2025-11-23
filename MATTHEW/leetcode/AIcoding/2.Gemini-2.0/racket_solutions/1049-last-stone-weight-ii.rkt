(define (last-stone-weight-ii stones)
  (let* ([n (length stones)]
         [sum (apply + stones)]
         [target (floor (/ sum 2))]
         [dp (make-vector (+ target 1) #f)])
    (vector-set! dp 0 #t)
    (for ([stone stones])
      (for ([i (reverse (range stone (+ target 1)))])
        (when (vector-ref dp (- i stone))
          (vector-set! dp i #t))))
    (let loop ([i target])
      (cond
        [(vector-ref dp i) (- sum (* 2 i))]
        [else (loop (- i 1))]))))