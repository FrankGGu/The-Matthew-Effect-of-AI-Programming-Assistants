(define (min-cut s)
  (define n (string-length s))

  (when (zero? n)
    (return 0))

  (define is-palindrome (make-vector n))
  (for ([i (in-range n)])
    (vector-set! is-palindrome i (make-vector n #f)))

  (for ([len (in-range 1 (+ n 1))])
    (for ([i (in-range (- n len) (+ 1))])
      (define j (+ i len -1))
      (cond
        [(= len 1) (vector-set! (vector-ref is-palindrome i) j #t)]
        [(= len 2) (vector-set! (vector-ref is-palindrome i) j (char=? (string-ref s i) (string-ref s j)))]
        [else (vector-set! (vector-ref is-palindrome i) j
                           (and (char=? (string-ref s i) (string-ref s j))
                                (vector-ref (vector-ref is-palindrome (+ i 1)) (- j 1))))])))

  (define dp (make-vector (+ n 1)))
  (vector-set! dp 0 0)

  (for ([i (in-range 1 (+ n 1))])
    (vector-set! dp i (- i 1))

    (for ([j (in-range i)])
      (when (vector-ref (vector-ref is-palindrome j) (- i 1))
        (cond
          [(= j 0) (vector-set! dp i 0)]
          [else (vector-set! dp i (min (vector-ref dp i) (+ (vector-ref dp j) 1)))]))))

  (vector-ref dp n))