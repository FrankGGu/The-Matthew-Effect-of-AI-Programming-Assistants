(define (isToeplitzMatrix matrix)
  (define n (length matrix))
  (define m (if (zero? n) 0 (length (vector-ref matrix 0))))

  (define (checkDiagonal row col)
    (let loop ((r row) (c col))
      (if (or (>= r n) (>= c m))
          #t
          (if (equal? (vector-ref (vector-ref matrix row) col)
                      (vector-ref (vector-ref matrix (+ r 1)) (+ c 1)))
              (loop (+ r 1) (+ c 1))
              #f))))

  (for/fold ([result #t]) ([i 0 n] result)
    (if (and result (checkDiagonal i 0))
        result
        #f))

  (for/fold ([result #t]) ([j 1 m] result)
    (if (and result (checkDiagonal 0 j))
        result
        #f)))