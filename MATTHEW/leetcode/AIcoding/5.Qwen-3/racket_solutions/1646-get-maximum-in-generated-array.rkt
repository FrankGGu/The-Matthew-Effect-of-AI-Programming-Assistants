(define (max-value n)
  (define arr (make-vector (+ n 1) 0))
  (vector-set! arr 0 0)
  (if (> n 0)
      (vector-set! arr 1 1))
  (for ([i (in-range 2 (+ n 1))])
    (cond
      [(even? i)
       (vector-set! arr i (+ (vector-ref arr (/ i 2)) (vector-ref arr (- i (/ i 2)))))]
      [else
       (vector-set! arr i (+ (vector-ref arr (/ (- i 1) 2)) (vector-ref arr (+ (/ (- i 1) 2) 1))))]))
  (vector-ref arr n))