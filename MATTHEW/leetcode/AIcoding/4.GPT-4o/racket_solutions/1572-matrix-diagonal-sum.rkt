(define (diagonalSum matrix)
  (define n (length matrix))
  (define sum (for/sum ([i (in-range n)])
                (+ (list-ref (list-ref matrix i) i)
                   (list-ref (list-ref matrix i) (- n i 1)))))
  (if (= n 1) sum
      (- sum (list-ref (list-ref matrix (/ n 2)) (/ n 2)))))