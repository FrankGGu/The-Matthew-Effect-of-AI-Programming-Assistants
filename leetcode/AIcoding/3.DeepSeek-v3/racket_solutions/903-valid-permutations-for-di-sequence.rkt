(define/contract (num-permutation-di-sequence s)
  (-> string? exact-integer?)
  (let* ([n (string-length s)]
         [dp (make-vector (add1 n) (make-vector (add1 n) 0))])
    (for ([j (in-range (add1 n))])
      (vector-set! (vector-ref dp 0) j 1))
    (for ([i (in-range 1 (add1 n))])
      (for ([j (in-range 0 (- (add1 n) i))])
        (if (char=? (string-ref s (- i 1)) #\D)
            (for ([k (in-range j i))])
              (vector-set! (vector-ref dp i) j 
                           (+ (vector-ref (vector-ref dp i) j) 
                              (vector-ref (vector-ref dp (- i 1)) k))))
            (for ([k (in-range (+ j 1) (add1 i))])
              (vector-set! (vector-ref dp i) j 
                           (+ (vector-ref (vector-ref dp i) j) 
                              (vector-ref (vector-ref dp (- i 1)) k)))))))
    (vector-ref (vector-ref dp n) 0)))