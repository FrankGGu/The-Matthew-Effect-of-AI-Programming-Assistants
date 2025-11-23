(define (maxRotateFunction A)
  (define n (length A))
  (define F (foldl (lambda (x y) (+ x y)) 0 (map-indexed (lambda (i v) (* i v)) A)))
  (define total-sum (foldl + 0 A))

  (define (rotate-function F k)
    (+ F total-sum (- (* n (list-ref A (- n k))) (* (list-ref A (- n k)) k))))

  (define max-F F)
  (for ([k (in-range 1 n)])
    (set! F (rotate-function F k))
    (set! max-F (max max-F F)))

  max-F)