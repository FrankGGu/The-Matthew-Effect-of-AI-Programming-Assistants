(define (bestRotation A)
  (define n (length A))
  (define score (make-vector n 0))

  (for ([i (in-range n)])
    (let* ([a (vector-ref A i)]
           [start (modulo (- i a) n)]
           [end (modulo (+ i 1) n)])
      (vector-set! score start (+ (vector-ref score start) 1))
      (vector-set! score end (- (vector-ref score end) 1))))

  (define (prefix-sum vec)
    (for ([i (in-range 1 n)])
      (vector-set! vec i (+ (vector-ref vec i) (vector-ref vec (- i 1))))))

  (prefix-sum score)

  (define max-score 0)
  (define best-k 0)

  (for ([i (in-range n)])
    (when (> (vector-ref score i) max-score)
      (set! max-score (vector-ref score i))
      (set! best-k i)))

  best-k)