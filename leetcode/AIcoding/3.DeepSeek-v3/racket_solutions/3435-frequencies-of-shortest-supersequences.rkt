(define/contract (shortest-supersequence-frequencies A B)
  (-> (listof exact-integer?) (listof exact-integer?) (listof exact-integer?))
  (let* ([m (length A)]
         [n (length B)]
         [dp (make-vector (add1 m) (make-vector (add1 n) 0))]
         [count (make-vector (add1 m) (make-vector (add1 n) 0))])
    (for ([i (in-range 1 (add1 m))])
      (for ([j (in-range 1 (add1 n))])
        (if (equal? (list-ref A (sub1 i)) (list-ref B (sub1 j)))
            (begin
              (vector-set! (vector-ref dp i) j (add1 (vector-ref (vector-ref dp (sub1 i)) (sub1 j))))
              (vector-set! (vector-ref count i) j (vector-ref (vector-ref count (sub1 i)) (sub1 j))))
            (let ([val1 (vector-ref (vector-ref dp (sub1 i)) j)]
                  [val2 (vector-ref (vector-ref dp i) (sub1 j))])
              (cond
                [(> val1 val2)
                 (vector-set! (vector-ref dp i) j val1)
                 (vector-set! (vector-ref count i) j (vector-ref (vector-ref count (sub1 i)) j))]
                [(< val1 val2)
                 (vector-set! (vector-ref dp i) j val2)
                 (vector-set! (vector-ref count i) j (vector-ref (vector-ref count i) (sub1 j)))]
                [else
                 (vector-set! (vector-ref dp i) j val1)
                 (vector-set! (vector-ref count i) j (+ (vector-ref (vector-ref count (sub1 i)) j)
                                                      (vector-ref (vector-ref count i) (sub1 j))))])))))
    (vector-ref (vector-ref count m) n)))