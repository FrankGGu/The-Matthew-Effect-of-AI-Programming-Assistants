(define (tribonacci n)
  (cond
    [(= n 0) 0]
    [(= n 1) 1]
    [(= n 2) 1]
    [else (let loop ((a 0) (b 1) (c 1) (i 3))
            (if (= i n)
                c
                (loop b c (+ a b c) (+ i 1))))]))

(tribonacci n)