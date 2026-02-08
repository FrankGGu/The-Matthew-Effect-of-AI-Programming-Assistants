(define (min-cut s)
  (define n (string-length s))
  (define dp (make-vector n +inf.0))
  (define is-palindrome (make-vector n #f))

  (for ([i (in-range n)])
    (vector-set! is-palindrome i #t)
    (for ([j (in-range i))]
      (when (and (equal? (string-ref s j) (string-ref s i))
                 (or (= j (+ i 1)) (vector-ref is-palindrome (+ j 1))))
        (vector-set! is-palindrome j #t)))
    (if (vector-ref is-palindrome 0)
        (vector-set! dp i 0)
        (for ([j (in-range i)])
          (when (equal? (string-ref s j) (string-ref s i))
            (if (or (= j 0) (vector-ref is-palindrome (+ j 1)))
                (vector-set! dp i (min (vector-ref dp i) (+ 1 (vector-ref dp j))))))))
    (if (equal? (vector-ref dp i) +inf.0)
        (vector-set! dp i (+ 1 (if (= i 0) 0 (vector-ref dp (- i 1)))))))

  (vector-ref dp (- n 1)))

(define (min-cut-wrapper s)
  (min-cut s))