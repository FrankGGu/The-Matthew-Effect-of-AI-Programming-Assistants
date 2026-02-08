(define/contract (min-cut s)
  (-> string? exact-integer?)
  (let* ([n (string-length s)]
         [dp (make-vector n 0)]
         [palindrome? (make-vector (add1 n) (make-vector n #f))])
    (for ([i (in-range n)])
      (vector-set! (vector-ref palindrome? i) i #t))
    (for ([len (in-range 2 (add1 n))])
      (for ([i (in-range 0 (- n len -1))])
        (let ([j (+ i len -1)])
          (when (and (char=? (string-ref s i) (string-ref s j))
            (vector-set! (vector-ref palindrome? i) j
                         (or (< len 3) (vector-ref (vector-ref palindrome? (add1 i)) (- j 1))))))))
    (for ([j (in-range n)])
      (vector-set! dp j j)
      (for ([i (in-range (add1 j))])
        (when (vector-ref (vector-ref palindrome? i) j)
          (vector-set! dp j
                       (if (= i 0)
                           0
                           (min (vector-ref dp j) (add1 (vector-ref dp (sub1 i)))))))
    (vector-ref dp (sub1 n))))