(define/contract (num-distinct s t)
  (-> string? string? exact-integer?)
  (let* ([m (string-length s)]
         [n (string-length t)]
         [dp (make-vector (add1 m) (make-vector (add1 n) 0))])
    (for ([i (in-range (add1 m))])
      (vector-set! (vector-ref dp i) 0 1))
    (for ([i (in-range 1 (add1 m))])
      (for ([j (in-range 1 (add1 n))])
        (if (equal? (string-ref s (sub1 i)) (string-ref t (sub1 j)))
            (vector-set! (vector-ref dp i) j (+ (vector-ref (vector-ref dp (sub1 i)) (sub1 j)) 
                                              (vector-ref (vector-ref dp (sub1 i)) j)))
            (vector-set! (vector-ref dp i) j (vector-ref (vector-ref dp (sub1 i)) j)))))
    (vector-ref (vector-ref dp m) n)))