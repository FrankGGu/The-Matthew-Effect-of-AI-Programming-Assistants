(define/contract (longest-palindrome-subseq s)
  (-> string? exact-integer?)
  (let* ([n (string-length s)]
         [dp (make-vector n (make-vector n 0))])
    (for ([i (in-range n)])
      (vector-set! (vector-ref dp i) i 1))
    (for* ([len (in-range 2 (add1 n))]
           [i (in-range 0 (- n len -1))]
           [let j (+ i len -1)])
      (if (equal? (string-ref s i) (string-ref s j))
          (vector-set! (vector-ref dp i) j (+ 2 (vector-ref (vector-ref dp (add1 i)) (sub1 j))))
          (vector-set! (vector-ref dp i) j (max (vector-ref (vector-ref dp (add1 i)) j)
                                               (vector-ref (vector-ref dp i) (sub1 j)))))))
    (vector-ref (vector-ref dp 0) (sub1 n))))