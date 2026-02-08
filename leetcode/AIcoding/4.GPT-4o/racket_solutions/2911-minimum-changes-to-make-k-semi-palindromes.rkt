(define (min-changes s k)
  (define n (string-length s))
  (define (is-palindrome? str)
    (let loop ((i 0) (j (sub1 (string-length str))))
      (if (>= i j)
          #t
          (if (char=? (string-ref str i) (string-ref str j))
              (loop (add1 i) (sub1 j))
              #f))))

  (define dp (make-vector (add1 n) (make-vector (add1 k) +inf.0)))
  (vector-set! dp 0 0)

  (for ((i (in-range 1 (add1 n))))
    (for ((j (in-range 1 (add1 k))))
      (define min-changes 0)
      (for ((l (in-range i)))
        (when (not (is-palindrome? (substring s l i)))
          (set! min-changes (add1 min-changes)))
        (vector-set! dp i j (min (vector-ref dp i j) (+ (vector-ref dp l (sub1 j)) min-changes)))))
      (vector-set! dp i j (min (vector-ref dp i j) (if (is-palindrome? (substring s 0 i)) 0 +inf.0)))))

  (for ((j (in-range 1 (add1 k))))
    (if (not (= (vector-ref dp n j) +inf.0))
        (return (vector-ref dp n j))))

  -1)

(min-changes "abc" 2)