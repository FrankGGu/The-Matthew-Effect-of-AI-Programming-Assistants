(define (countPalindromicSubsequences s)
  (define n (string-length s))
  (define dp (make-vector n (make-vector n 0)))

  (for ([i (in-range n)])
    (vector-set! dp i i 1))

  (for ([length (in-range 2 (add1 n))])
    (for ([i (in-range (- n length 1))])
      (define j (+ i length -1))
      (if (char=? (string-ref s i) (string-ref s j))
          (begin
            (vector-set! dp i j (+ 2 (vector-ref dp (+ i 1) (- j 1)) 1)))
            (if (> (- j i) 1)
                (vector-set! dp i j (+ (vector-ref dp i j) (- (vector-ref dp (+ i 1) j) (vector-ref dp i (+ j -1))))))
                (vector-set! dp i j (+ (vector-ref dp i j) 1))))
          (vector-set! dp i j (+ (vector-ref dp (+ i 1) j) (vector-ref dp i (+ j -1)) (- (vector-ref dp (+ i 1) (+ j -1))))))))

  (vector-ref dp 0 (- n 1)))

(countPalindromicSubsequences "bccb")