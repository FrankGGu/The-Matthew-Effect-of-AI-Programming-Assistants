(define (min-cost n cuts)
  (define cuts-sorted (sort cuts <))
  (define cuts-extended (cons 0 (append cuts-sorted (list n))))
  (define len (length cuts-extended))

  (define dp (make-vector len (make-vector len 0)))

  (for ([i (in-range (- len 2) -1 -1)])
    (for ([j (in-range (+ i 2) len)])
      (define min-val +inf.0)
      (for ([k (in-range (+ i 1) j)])
        (set! min-val (min min-val (+ (vector-ref (vector-ref dp i k) i) (vector-ref (vector-ref dp k j) k)))))
      (vector-set! (vector-ref dp i j) i (+ (- (list-ref cuts-extended j) (list-ref cuts-extended i)) min-val))))

  (vector-ref (vector-ref dp 0 (- len 1)) 0))