(define (min-path-sum grid)
  (define rows (length grid))
  (define cols (length (car grid)))
  (define dp (make-vector rows (lambda () (make-vector cols 0))))

  (vector-set! dp 0 0 (car (car grid)))

  (for ([i (in-range 1 rows)])
    (vector-set! dp i 0 (+ (vector-ref dp (- i 1)) (car (vector-ref grid i)))))

  (for ([j (in-range 1 cols)])
    (vector-set! dp 0 j (+ (vector-ref dp 0 (- j 1)) (car (vector-ref grid 0 j)))))

  (for ([i (in-range 1 rows)])
    (for ([j (in-range 1 cols)])
      (vector-set! dp i j (min (+ (vector-ref dp (- i 1) j) (car (vector-ref grid i j)))
                                 (+ (vector-ref dp i (- j 1)) (car (vector-ref grid i j)))))))

  (vector-ref dp (- rows 1) (- cols 1)))

(define (minPathSum grid)
  (min-path-sum grid))