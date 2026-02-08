(define (maxProduct nums k)
  (define n (length nums))
  (define dp (make-vector (+ 1 n) 0))
  (define mod 1000000007)

  (for ([i (in-range n)])
    (for ([j (in-range i -1 -1)])
      (let ([sum (+ (vector-ref dp j) (vector-ref nums i))])
        (when (= sum k)
          (vector-set! dp (+ j 1) (mod (+ (vector-ref dp (+ j 1)) (vector-ref nums i)) mod))))))
    (vector-set! dp 0 (mod (+ (vector-ref dp 0) (vector-ref nums i)) mod)))

  (apply max (vector->list dp)))

(maxProduct '(1 2 3 4) 5)