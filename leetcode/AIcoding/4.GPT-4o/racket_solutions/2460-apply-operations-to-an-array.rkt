(define (applyOperations nums)
  (define n (length nums))
  (define result (make-vector n 0))
  (define j 0)

  (for ([i (in-range n)])
    (when (and (= (vector-ref nums i) 0) (> i 0) (= (vector-ref nums (- i 1)) (vector-ref nums i)))
      (vector-set! nums (- i 1) (+ (vector-ref nums (- i 1)) (vector-ref nums i)))
      (vector-set! nums i 0)))

  (for ([i (in-range n)])
    (when (> (vector-ref nums i) 0)
      (vector-set! result j (vector-ref nums i))
      (set! j (+ j 1))))

  (vector->list (subvector result 0 j)))

(applyOperations '(1 2 2 1 0 0))