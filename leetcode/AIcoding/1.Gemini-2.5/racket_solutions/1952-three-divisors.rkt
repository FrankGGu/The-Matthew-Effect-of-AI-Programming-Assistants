(define (is-prime? x)
  (cond
    [(< x 2) #f]
    [(= x 2) #t]
    [(even? x) #f]
    [else
     (let loop ([i 3])
       (cond
         [(> (* i i) x) #t]
         [(zero? (modulo x i)) #f]
         [else (loop (+ i 2))]))]))

(define (has-three-divisors n)
  (if (< n 4)
      #f
      (let* ([root (exact-round (sqrt n))]
             [is-perfect-square (= (* root root) n)])
        (and is-perfect-square (is-prime? root)))))