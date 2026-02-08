(define MOD 1000000007)

(define (count-special-subsequences nums)
  (let loop ([i 0] [a 0] [b 0] [c 0])
    (cond
      [(= i (length nums))
       (modulo c MOD)]
      [else
       (let ([x (list-ref nums i)])
         (cond
           [(= x 0)
            (loop (+ i 1) (modulo (+ (* 2 a) 1) MOD) b c)]
           [(= x 1)
            (loop (+ i 1) a (modulo (+ (* 2 b) a) MOD) c)]
           [else
            (loop (+ i 1) a b (modulo (+ (* 2 c) b) MOD))]))])))