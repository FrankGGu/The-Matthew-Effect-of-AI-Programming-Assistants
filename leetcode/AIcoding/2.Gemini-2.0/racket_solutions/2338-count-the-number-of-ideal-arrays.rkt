(define (count-ideal-arrays n max-value)
  (define mod 1000000007)
  (define (combinations n k)
    (if (or (< n 0) (< k 0) (> k n))
        0
        (let loop ((n n) (k k) (res 1))
          (if (zero? k)
              res
              (loop (- n 1) (- k 1) (modulo (* res n (inv k mod)) mod))))))

  (define (inv a mod)
    (let loop ((a a) (m mod) (x 1) (y 0))
      (if (= a 1)
          x
          (let ((q (quotient m a)))
            (loop a (modulo (- m (* q a)) mod) y (modulo (- x (* q y)) mod))))))

  (let loop ((i 1) (count 0))
    (if (> i max-value)
        count
        (let ((num-factors 0) (j i))
          (while (<= j max-value)
                 (set! num-factors (+ num-factors 1))
                 (set! j (* j 2)))
          (set! count (modulo (+ count (combinations (- n 1) (- num-factors 1))) mod))
          (loop (+ i 1) count))))