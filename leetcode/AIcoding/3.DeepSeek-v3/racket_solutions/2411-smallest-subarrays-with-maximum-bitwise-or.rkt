(define (smallest-subarrays nums)
  (let* ([n (length nums)]
         [result (make-vector n 0)]
         [last (make-vector 32 -1)])
    (for ([i (in-range (sub1 n) -1 -1)])
      (vector-set! result i 1)
      (for ([b (in-range 0 32)])
        (when (bitwise-bit-set? (list-ref nums i) b)
          (vector-set! last b i))
      (let ([max_last (apply max (vector->list last))])
        (when (> max_last i)
          (vector-set! result i (+ 1 (- max_last i)))))
    (vector->list result)))