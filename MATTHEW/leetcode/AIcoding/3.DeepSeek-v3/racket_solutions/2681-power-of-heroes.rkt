(define (sum-of-power nums)
  (define mod 1000000007)
  (define (power x n)
    (if (= n 0)
        1
        (let loop ([res 1] [x x] [n n])
          (if (<= n 0)
              res
              (loop (if (odd? n) (modulo (* res x) mod) res) 
                   (modulo (* x x) mod) 
                   (quotient n 2))))))
  (let* ([sorted-nums (sort nums <)]
         [n (length sorted-nums)]
         [dp (make-vector n 0)]
         [pre (make-vector n 0)]
         [res 0])
    (for ([i (in-range n)])
      (vector-set! dp i (power (list-ref sorted-nums i) 3))
      (vector-set! pre i (if (= i 0) 0 (vector-ref pre (- i 1))))
    (for ([i (in-range n)])
    (for ([i (in-range n)])
      (let ([current (list-ref sorted-nums i)])
        (set! res (modulo (+ res (vector-ref dp i)) mod))
      (when (< (+ i 1) n)
        (for ([j (in-range (+ i 1) n)])
          (vector-set! dp j 
                       (modulo (* (list-ref sorted-nums j) 
                                  (+ (* 2 (vector-ref dp j)) 
                                  (modulo (* current (power (list-ref sorted-nums j) 2)) mod)) 
                       mod))))
    res))