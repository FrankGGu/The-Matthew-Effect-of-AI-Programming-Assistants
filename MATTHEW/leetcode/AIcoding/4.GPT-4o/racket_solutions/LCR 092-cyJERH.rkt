(define (minimumDeletions s)
  (define n (string-length s))
  (define dp (make-vector (+ n 1) (make-vector 2 0)))
  (for ([i (in-range n)])
    (let* ([current (char->integer (string-ref s i))]
           [prev (if (= i 0) 0 (char->integer (string-ref s (- i 1))))])
      (vector-set! dp (+ i 1) (vector (vector-ref dp i 0) (vector-ref dp i 1)))
      (if (>= current prev)
          (vector-set! dp (+ i 1) (vector (vector-ref dp i 0) (1+ (vector-ref dp i 1))))
          (vector-set! dp (+ i 1) (vector (1+ (vector-ref dp i 0)) (vector-ref dp i 1))))))
  (min (vector-ref dp n 0) (vector-ref dp n 1)))

(minimumDeletions "cba")