(define (-capsule- cnt limit)
  (let loop ([x 0] [y 0] [res 0])
    (cond
      [(> res limit) (- res 1)]
      [(= y cnt) (loop (add1 x) 0 res)]
      [else (loop x (add1 y) (+ res (bitwise-and x y))])))

(define (capsule cnt limit)
  (if (or (<= cnt 0) (<= limit 0))
      0
      (-capsule- cnt limit)))