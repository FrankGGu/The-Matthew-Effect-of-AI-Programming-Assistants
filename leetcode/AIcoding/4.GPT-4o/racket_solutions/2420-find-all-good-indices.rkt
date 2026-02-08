(define (good-indices nums k)
  (define n (length nums))
  (define left (make-vector n 0))
  (define right (make-vector n 0))

  (for ([i (in-range 1 n)])
    (if (<= (vector-ref nums i) (vector-ref nums (- i 1)))
        (vector-set! left i (+ 1 (vector-ref left (- i 1)))))
    (vector-set! left i (max (vector-ref left i) 0)))

  (for ([i (in-range (- n 2) -1 -1)])
    (if (<= (vector-ref nums i) (vector-ref nums (+ i 1)))
        (vector-set! right i (+ 1 (vector-ref right (+ i 1)))))
    (vector-set! right i (max (vector-ref right i) 0)))

  (define result '())
  (for ([i (in-range k (- n k))])
    (when (and (>= (vector-ref left i) k) (>= (vector-ref right i) k))
      (set! result (cons i result))))

  (reverse result))

(define (findAllGoodIndices nums k)
  (good-indices nums k))