(define (longest-palindrome-subseq s)
  (define n (string-length s))
  (define dp (make-vector n (make-vector n 0)))
  (for ([i (in-range n)])
    (vector-set! (vector-ref dp i) i 1))
  (for ([len (in-range 2 (+ n 1))])
    (for ([i (in-range (- n len) )])
      (define j (+ i len -1))
      (if (equal? (string-ref s i) (string-ref s j))
          (vector-set! (vector-ref dp i) j
                       (+ 2 (if (< (+ i 1) (- j 1)) (vector-ref (vector-ref dp (+ i 1)) (- j 1)) 0)))
          (vector-set! (vector-ref dp i) j
                       (max (if (< (+ i 1) n) (vector-ref (vector-ref dp (+ i 1)) j) 0) (if (< 0 j) (vector-ref (vector-ref dp i) (- j 1)) 0)))))
  (vector-ref (vector-ref dp 0) (- n 1)))