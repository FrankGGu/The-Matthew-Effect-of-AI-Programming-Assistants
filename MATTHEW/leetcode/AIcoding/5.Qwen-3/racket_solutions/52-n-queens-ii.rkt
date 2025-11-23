(define (total-n-queens n)
  (define (valid? row col board)
    (for/and ([i (in-range row)])
      (not (= (abs (- i row)) (abs (- (list-ref board i) col))))))
  (define (backtrack row board)
    (if (= row n)
        1
        (for/sum ([col (in-range n)]
                  #:when (valid? row col board))
          (backtrack (+ row 1) (append board (list col))))))
  (backtrack 0 '()))