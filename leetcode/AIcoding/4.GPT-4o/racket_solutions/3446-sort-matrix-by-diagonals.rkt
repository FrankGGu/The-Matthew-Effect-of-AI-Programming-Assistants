(define (diagonalSort matrix)
  (define n (length matrix))
  (define m (length (car matrix)))
  (define diagonals (make-hash))

  (for ([i (in-range n)]
        [j (in-range m)])
    (let ([key (+ i j)])
      (hash-set! diagonals key (cons (list-ref (list-ref matrix i) j) (hash-ref diagonals key '())))))

  (for ([key (in-range (+ n m -1))])
    (when (hash-has? diagonals key)
      (hash-set! diagonals key (sort (hash-ref diagonals key) <))))

  (for ([i (in-range n)]
        [j (in-range m)])
    (let ([key (+ i j)])
      (list-set! (list-set! matrix i j) 0 (car (hash-ref diagonals key '()))))))

  matrix)