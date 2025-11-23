(define (ways-to-split-array nums)
  (let* ([n (length nums)]
         [prefix (make-vector n 0)])
    (vector-set! prefix 0 (list-ref nums 0))
    (for ([i (in-range 1 n)])
      (vector-set! prefix i (+ (vector-ref prefix (- i 1)) (list-ref nums i))))
    (let loop ([i 0] [res 0])
      (if (>= i (- n 1))
          res
          (let ([left (vector-ref prefix i)]
                [right (- (vector-ref prefix (- n 1)) left)])
            (if (>= left right)
                (loop (+ i 1) (+ res 1))
                (loop (+ i 1) res)))))))