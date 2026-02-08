(define (matrixBlockSum mat K)
  (define rows (length mat))
  (define cols (length (car mat)))
  (define prefix-sum (make-vector (+ rows 1) (make-vector (+ cols 1) 0)))

  (for ([i (in-range rows)])
    (for ([j (in-range cols)])
      (vector-set! prefix-sum (+ i 1) (+ (vector-ref prefix-sum (+ i 1)) (vector-ref (vector-ref mat i) j)))
      (vector-set! prefix-sum (+ i 1) j (+ (vector-ref prefix-sum (+ i 1) j) (vector-ref (vector-ref prefix-sum i) j)))))

  (define result (make-vector rows (make-vector cols 0)))

  (for ([i (in-range rows)])
    (for ([j (in-range cols)])
      (define r1 (max 0 (- i K)))
      (define r2 (min (- rows 1) (+ i K)))
      (define c1 (max 0 (- j K)))
      (define c2 (min (- cols 1) (+ j K)))
      (vector-set! result i j (- (vector-ref prefix-sum (+ r2 1) (+ c2 1))
                                 (vector-ref prefix-sum (+ r1 1) (+ c2 1))
                                 (vector-ref prefix-sum (+ r2 1) (+ c1 1))
                                 (vector-ref prefix-sum (+ r1 1) (+ c1 1))))))

  (vector->list (vector-map (lambda (row) (vector->list row)) result)))