(define/contract (minimum-delete-sum s1 s2)
  (-> string? string? exact-integer?)
  (define m (string-length s1))
  (define n (string-length s2))
  (define dp (make-vector (add1 m) (make-vector (add1 n) 0)))
  (for ([i (in-range (sub1 m) -1 -1)])
    (vector-set! (vector-ref dp i) n 
                 (+ (vector-ref (vector-ref dp (add1 i)) n) 
                    (char->integer (string-ref s1 i)))))
  (for ([j (in-range (sub1 n) -1 -1)])
    (vector-set! (vector-ref dp m) j 
                 (+ (vector-ref (vector-ref dp m) (add1 j)) 
                    (char->integer (string-ref s2 j)))))
  (for ([i (in-range (sub1 m) -1 -1)])
    (for ([j (in-range (sub1 n) -1 -1)])
      (if (equal? (string-ref s1 i) (string-ref s2 j))
          (vector-set! (vector-ref dp i) j 
                       (vector-ref (vector-ref dp (add1 i)) (add1 j)))
          (vector-set! (vector-ref dp i) j 
                       (min (+ (vector-ref (vector-ref dp (add1 i)) j) 
                               (char->integer (string-ref s1 i)))
                            (+ (vector-ref (vector-ref dp i) (add1 j)) 
                               (char->integer (string-ref s2 j)))))))
  (vector-ref (vector-ref dp 0) 0))