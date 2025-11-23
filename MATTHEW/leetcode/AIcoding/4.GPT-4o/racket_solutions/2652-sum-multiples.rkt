(define (sum-multiples n)
  (define (is-multiple? x)
    (or (= (modulo x 3) 0) (= (modulo x 5) 0) (= (modulo x 7) 0)))
  (define (sum-iter i acc)
    (if (> i n)
        acc
        (sum-iter (+ i 1) (if (is-multiple? i) (+ acc i) acc))))
  (sum-iter 1 0))