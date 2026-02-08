(provide count-submatrices)

(define (count-submatrices matrix x y)
  (define rows (length matrix))
  (define cols (length (car matrix)))

  (define (prefix-sum)
    (define prefix (make-matrix (+ rows 1) (+ cols 1) 0))
    (for* ([i (in-range 1 (+ rows 1))]
           [j (in-range 1 (+ cols 1))])
      (matrix-set! prefix i j (+ (matrix-ref matrix (- i 1) (- j 1))
                                 (matrix-ref prefix i (- j 1))
                                 (matrix-ref prefix (- i 1) j)
                                 (- (matrix-ref prefix (- i 1) (- j 1))))))
    prefix)

  (define prefix (prefix-sum))

  (define (count-x i1 j1 i2 j2)
    (let ([total (- (matrix-ref prefix i2 j2)
                    (matrix-ref prefix i1 (- j2 1))
                    (matrix-ref prefix (- i2 1) j1)
                    (+ (matrix-ref prefix (- i1 1) (- j1 1))))])
      (count (lambda (row) (equal? row x)) (flatten (list (list total))))))

  (define (count-y i1 j1 i2 j2)
    (let ([total (- (matrix-ref prefix i2 j2)
                    (matrix-ref prefix i1 (- j2 1))
                    (matrix-ref prefix (- i2 1) j1)
                    (+ (matrix-ref prefix (- i1 1) (- j1 1))))])
      (count (lambda (row) (equal? row y)) (flatten (list (list total))))))

  (let loop ([i1 (in-range rows)]
             [j1 (in-range cols)]
             [count 0])
    (if (= i1 rows)
        count
        (if (= j1 cols)
            (loop (+ i1 1) 0 count)
            (let loop2 ([i2 (in-range i1 rows)]
                        [j2 (in-range j1 cols)]
                        [count2 count])
              (if (= i2 rows)
                  (loop i1 (+ j1 1) count2)
                  (if (= j2 cols)
                      (loop2 (+ i2 1) j1 count2)
                      (let* ([submatrix (for/list ([i (in-range i1 (+ i2 1))])
                                           (for/list ([j (in-range j1 (+ j2 1))])
                                             (list-ref (list-ref matrix i) j)))])
                        (let ([x-count (count (lambda (elem) (equal? elem x)) (flatten submatrix))]
                              [y-count (count (lambda (elem) (equal? elem y)) (flatten submatrix))])
                          (if (= x-count y-count)
                              (loop2 i2 (+ j2 1) (+ count2 1))
                              (loop2 i2 (+ j2 1) count2)))))))))))

(define (matrix-ref matrix row col)
  (list-ref (list-ref matrix row) col))

(define (matrix-set! matrix row col value)
  (set! (list-ref (list-ref matrix row) col) value))

(define (make-matrix rows cols initial-value)
  (for/list ([i (in-range rows)])
    (for/list ([j (in-range cols)])
      initial-value)))