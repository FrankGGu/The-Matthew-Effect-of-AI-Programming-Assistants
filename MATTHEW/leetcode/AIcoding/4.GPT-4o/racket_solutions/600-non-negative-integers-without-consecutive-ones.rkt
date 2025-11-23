(define (findIntegers n)
  (define fib (vector 0 1))
  (do ((i 2 (+ i 1)))
      ((>= i 32))
    (vector-set! fib i (+ (vector-ref fib (- i 1)) (vector-ref fib (- i 2)))))
  (define (count n)
    (if (= n 0) 1
        (if (= (bitwise-and n 1) 1)
            0
            (+ (count (bitwise-shift-right n 1)) (vector-ref fib (add1 (bitwise-count-ones (bitwise-and n (bitwise-not 1)))))))))
  (+ (count n) (vector-ref fib (add1 (bitwise-count-ones n)))))