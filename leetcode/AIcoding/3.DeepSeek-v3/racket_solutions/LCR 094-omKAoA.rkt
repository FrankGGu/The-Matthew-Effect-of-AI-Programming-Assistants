(define/contract (min-cut s)
  (-> string? exact-integer?)
  (let* ([n (string-length s)]
         [dp (make-vector n 0)]
         [is-palindrome (make-vector (for/vector ([i n]) (make-vector n #f))])
    (for ([i (in-range n)])
      (for ([j (in-range (add1 i))])
        (when (and (char=? (string-ref s j) (string-ref s i))
                   (or (< (- i j) 2) (vector-ref (vector-ref is-palindrome (add1 j)) (- i 1))))
          (vector-set! (vector-ref is-palindrome j) i #t))))
    (for ([i (in-range n)])
      (if (vector-ref (vector-ref is-palindrome 0) i)
          (vector-set! dp i 0)
          (begin
            (vector-set! dp i i)
            (for ([j (in-range i)])
              (when (vector-ref (vector-ref is-palindrome (add1 j)) i)
                (vector-set! dp i (min (vector-ref dp i) (add1 (vector-ref dp j))))))))
    (vector-ref dp (sub1 n))))