(define/contract (max-palindromes s k)
  (-> string? exact-integer? exact-integer?)
  (define n (string-length s))
  (define dp (make-vector n 0))
  (define is-palindrome (make-vector (add1 n) (make-vector (add1 n) #f)))

  (for* ([i (in-range n -1 -1)]
         [j (in-range i n)])
    (vector-set! (vector-ref is-palindrome i) j
                 (or (= i j)
                     (and (char=? (string-ref s i) (string-ref s j))
                          (or (< (add1 i) j)
                              (vector-ref (vector-ref is-palindrome (add1 i)) (sub1 j)))))))

  (for ([i (in-range n)])
    (if (< i 1)
        (vector-set! dp i 0)
        (vector-set! dp i (vector-ref dp (sub1 i))))
    (for ([j (in-range (sub1 (add1 (- i k -1))) -1 -1)])
      (when (vector-ref (vector-ref is-palindrome j) i)
        (if (< j 1)
            (vector-set! dp i (max (vector-ref dp i) 1))
            (vector-set! dp i (max (vector-ref dp i) (add1 (vector-ref dp (sub1 j))))))))
  (vector-ref dp (sub1 n)))