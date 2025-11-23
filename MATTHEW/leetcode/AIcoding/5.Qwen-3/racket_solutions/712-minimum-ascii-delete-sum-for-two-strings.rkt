(define (minimum-ascii-delete-sum-for-two-strings s1 s2)
  (define (min a b) (if (< a b) a b))
  (define (max a b) (if (> a b) a b))
  (define m (string-length s1))
  (define n (string-length s2))
  (define dp (make-vector (+ m 1) (make-vector (+ n 1) 0)))
  (for ([i (in-range (+ m 1))])
    (for ([j (in-range (+ n 1))])
      (cond
        [(and (= i 0) (= j 0)) (vector-set! (vector-ref dp i) j 0)]
        [(= i 0) (vector-set! (vector-ref dp i) j (+ (vector-ref (vector-ref dp i) (- j 1)) (char->integer (string-ref s2 (- j 1))))) ]
        [(= j 0) (vector-set! (vector-ref dp i) j (+ (vector-ref (vector-ref dp (- i 1) ) j) (char->integer (string-ref s1 (- i 1))))) ]
        [else
         (if (= (string-ref s1 (- i 1)) (string-ref s2 (- j 1)))
             (vector-set! (vector-ref dp i) j (vector-ref (vector-ref dp (- i 1) ) (- j 1)))
             (vector-set! (vector-ref dp i) j (min (+ (vector-ref (vector-ref dp (- i 1) ) j) (char->integer (string-ref s1 (- i 1))))
                                                 (+ (vector-ref (vector-ref dp i) (- j 1)) (char->integer (string-ref s2 (- j 1)))) )))])))
  (vector-ref (vector-ref dp m) n))