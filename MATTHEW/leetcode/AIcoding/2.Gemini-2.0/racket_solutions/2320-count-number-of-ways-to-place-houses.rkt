(define (count-house-placements n)
  (define MOD 1000000007)
  (define (square x)
    (modulo (* x x) MOD))

  (define (fib n)
    (let loop ((a 0) (b 1) (i n))
      (if (= i 0)
          a
          (loop b (modulo (+ a b) MOD) (- i 1)))))

  (square (fib (+ n 1))))