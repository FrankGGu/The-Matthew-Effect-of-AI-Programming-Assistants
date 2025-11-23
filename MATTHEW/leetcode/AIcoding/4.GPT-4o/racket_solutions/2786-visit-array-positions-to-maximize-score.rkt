(define (maxScoreIndices nums)
  (define n (length nums))
  (define prefix-sum (make-vector (add1 n) 0))
  (define suffix-sum (make-vector (add1 n) 0))

  (for ((i (in-range n)))
    (vector-set! prefix-sum (add1 i) (+ (vector-ref prefix-sum i) (if (= (vector-ref nums i) 0) 1 0))))

  (for ((i (in-range (- n 1) -1 -1)))
    (vector-set! suffix-sum i (+ (vector-ref suffix-sum (add1 i)) (if (= (vector-ref nums i) 1) 1 0))))

  (define max-score 0)
  (define result '())

  (for ((i (in-range (add1 n))))
    (define score (+ (vector-ref prefix-sum i) (vector-ref suffix-sum i)))
    (when (> score max-score)
      (set! max-score score)
      (set! result (list i)))
    (when (= score max-score)
      (set! result (cons i result))))

  (reverse result))