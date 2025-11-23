(define (count-vowel-permutation n)
  (define mod 1000000007)
  (define (matrix-multiply a b)
    (define size (length a))
    (define result (make-matrix size size 0))
    (for ((i (in-range size))
          (j (in-range size)))
      (for ((k (in-range size)))
        (set! (matrix-ref result i j)
              (modulo (+ (matrix-ref result i j)
                         (* (matrix-ref a i k) (matrix-ref b k j)))
                      mod))))
    result)

  (define (matrix-power matrix n)
    (define size (length matrix))
    (define result (make-identity-matrix size 0))
    (for (; (positive? n))
         (#:break (= n 0))
         (#:update (set! n (quotient n 2))))
      (when (odd? n)
        (set! result (matrix-multiply result matrix)))
      (set! matrix (matrix-multiply matrix matrix)))
    result)

  (define (make-matrix rows cols initial-value)
    (make-vector rows (make-vector cols initial-value)))

  (define (matrix-ref matrix row col)
    (vector-ref (vector-ref matrix row) col))

  (define (make-identity-matrix size initial-value)
    (define matrix (make-matrix size size initial-value))
    (for ((i (in-range size)))
      (set! (vector-ref (vector-ref matrix i) i) 1))
    matrix)

  (define adjacency-matrix
    (vector #(#f #t #f #f #f)
            #(#t #f #t #f #f)
            #(#t #t #f #t #t)
            #(#f #f #t #f #t)
            #(#t #f #f #f #f)))

  (define transition-matrix
    (make-matrix 5 5 0))

  (for ((i (in-range 5))
        (j (in-range 5)))
    (if (vector-ref (vector-ref adjacency-matrix i) j)
        (set! (matrix-ref transition-matrix i j) 1)
        (set! (matrix-ref transition-matrix i j) 0)))

  (define powered-matrix (matrix-power transition-matrix (- n 1)))

  (let loop ((i 0) (sum 0))
    (if (= i 5)
        sum
        (loop (+ i 1) (modulo (+ sum (vector-sum (vector-ref powered-matrix i))) mod))))

  (define (vector-sum vec)
    (let loop ((i 0) (sum 0))
      (if (= i (vector-length vec))
          sum
          (loop (+ i 1) (modulo (+ sum (vector-ref vec i)) mod)))))

  (modulo (vector-sum (vector 1 1 1 1 1)) mod)
  (let ((initial-counts (vector 1 1 1 1 1)))
    (let ((final-counts (make-vector 5 0)))
      (for ((i (in-range 5)))
        (for ((j (in-range 5)))
          (set! (vector-ref final-counts i)
                (modulo (+ (vector-ref final-counts i)
                           (* (vector-ref initial-counts j)
                              (matrix-ref powered-matrix j i)))
                        mod))))
      (vector-sum final-counts))))