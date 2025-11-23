(define (maxScoreIndices nums)
  (define n (length nums))
  (define left-zeros (make-vector (+ n 1) 0))
  (define right-ones (make-vector (+ n 1) 0))

  (for ((i (in-range n)))
    (vector-set! left-zeros (+ i 1) (+ (vector-ref left-zeros i) (if (= (vector-ref nums i) 0) 1 0))))

  (for ((i (in-range (- n 1) -1 -1)))
    (vector-set! right-ones i (+ (vector-ref right-ones (+ i 1)) (if (= (vector-ref nums i) 1) 1 0))))

  (define max-score 0)
  (define result '())

  (for ((i (in-range (+ n 1))))
    (define score (+ (vector-ref left-zeros i) (vector-ref right-ones i)))
    (when (= score max-score)
      (set! result (cons i result)))
    (when (> score max-score)
      (set! max-score score)
      (set! result (list i))))

  (reverse result))