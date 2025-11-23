(define (maximum-beauty nums k)
  (let* ([sorted (sort nums <)]
         [n (length sorted)]
         [i 0]
         [max-beauty 0])
    (for ([j (in-range n)])
      (while (and (< i n) (> (- (list-ref sorted j) (list-ref sorted i)) (* 2 k)))
        (set! i (+ i 1))
      (set! max-beauty (max max-beauty (- j i -1)))
    max-beauty))