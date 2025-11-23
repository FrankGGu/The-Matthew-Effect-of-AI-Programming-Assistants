(define MOD 1000000007)

(define (count-palindromic-subsequences s)
  (let* ([n (string-length s)]
         [dp (make-vector (expt n 2) 0)])
    (for ([i (in-range (- n 1) -1 -1)])
      (for ([j (in-range i n)])
        (cond
          [(= i j) (vector-set! dp (+ (* i n) j) 1)]
          [(= (string-ref s i) (string-ref s j))
           (let ([left (add1 i)]
                 [right (sub1 j)])
             (vector-set! dp (+ (* i n) j)
                          (+ (if (<= left right)
                                 (vector-ref dp (+ (* left n) right))
                                 0)
                             2)
                          MOD))]
          [else
           (let ([left (add1 i)]
                 [right (sub1 j)]
                 [down (vector-ref dp (+ (* (add1 i) n) j)]
                 [left (vector-ref dp (+ (* i n) (sub1 j)))])
             (vector-set! dp (+ (* i n) j)
                          (- (+ down left MOD)
                             (if (<= (add1 i) (sub1 j))
                                 (vector-ref dp (+ (* (add1 i) n) (sub1 j)))
                                 0)
                          MOD))]))))
    (vector-ref dp 0 (sub1 n))))