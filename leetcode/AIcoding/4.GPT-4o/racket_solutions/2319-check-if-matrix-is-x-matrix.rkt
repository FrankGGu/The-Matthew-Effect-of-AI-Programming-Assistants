(define (checkXMatrix matrix)
  (define n (length matrix))
  (for/fold ([is-x #t]) ([i (in-range n)])
    (for/fold ([is-x is-x]) ([j (in-range n)])
      (if (or (= i j) (= (+ i j) (- n 1)))
          (if (= (matrix-ref matrix i j) 0)
              #f
              is-x)
          (if (= (matrix-ref matrix i j) 0)
              is-x
              #f)))))