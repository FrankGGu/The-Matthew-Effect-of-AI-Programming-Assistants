#lang racket

(define (num-prime-arrangements n)
  (define (is-prime? num)
    (if (<= num 1)
        #f
        (let loop ([i 2])
          (if (> (* i i) num)
              #t
              (if (zero? (modulo num i))
                  #f
                  (loop (+ i 1)))))))

  (define (count-primes up-to)
    (let loop ([i 2] [count 0])
      (if (> i up-to)
          count
          (loop (+ i 1) (if (is-prime? i) (+ count 1) count)))))

  (define (factorial x)
    (if (<= x 1)
        1
        (modulo (* x (factorial (- x 1))) 1000000007)))

  (let ([prime-count (count-primes n)])
    (modulo (* (factorial prime-count) (factorial (- n prime-count))) 1000000007))