(define (painting-plan n k)
  (define (comb m k)
    (if (or (<= k 0) (>= k m))
        1
        (let loop ([i 1] [res 1])
          (if (> i k)
              res
              (loop (+ i 1) (* res (/ (- m i -1) i)))))))
  (let ([res 0])
    (for ([a (in-range 0 (+ n 1))])
      (for ([b (in-range 0 (+ n 1))])
        (when (= (- (+ (* a n) (* b (- n a))) k)
          (set! res (+ res (* (comb n a) (comb n b)))))))
    res))