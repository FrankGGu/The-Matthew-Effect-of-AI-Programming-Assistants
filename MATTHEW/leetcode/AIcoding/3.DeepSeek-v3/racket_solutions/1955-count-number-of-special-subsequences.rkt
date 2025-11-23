(define (count-special-subsequences nums)
  (define mod 1000000007)
  (let loop ([i 0] [a 0] [b 0] [c 0])
    (cond
      [(= i (length nums)) c]
      [else
       (let ([x (list-ref nums i)])
       (cond
         [(= x 0)
          (loop (+ i 1) (modulo (+ (* 2 a) 1) mod) b c)]
         [(= x 1)
          (loop (+ i 1) a (modulo (+ (* 2 b) a) mod) c)]
         [(= x 2)
          (loop (+ i 1) a b (modulo (+ (* 2 c) b) mod))]))])))