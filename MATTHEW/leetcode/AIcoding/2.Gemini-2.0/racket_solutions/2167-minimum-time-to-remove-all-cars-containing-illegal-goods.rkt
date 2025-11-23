(define (minimum-time s cost)
  (define n (string-length s))
  (define dp (make-vector (+ n 1) 0))

  (for ([i (in-range 1 (+ n 1))])
    (vector-set! dp i (vector-ref dp (- i 1)) (+ cost (string->number (substring s (- i 1) i)))))

  (for ([i (in-range (- n 1) -1 -1)])
    (vector-set! dp i (min (vector-ref dp i) (+ (vector-ref dp (+ i 1)) cost (string->number (substring s i (+ i 1)))))))

  (vector-ref dp 0))