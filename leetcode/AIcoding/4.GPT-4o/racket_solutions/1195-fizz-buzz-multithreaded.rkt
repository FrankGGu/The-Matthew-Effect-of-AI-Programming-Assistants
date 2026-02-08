#lang racket

(define (fizz n)
  (for ([i (in-range 1 (+ n 1))])
    (cond
      [(and (= (modulo i 3) 0) (= (modulo i 5) 0)) (printf "FizzBuzz\n")]
      [(= (modulo i 3) 0) (printf "Fizz\n")]
      [(= (modulo i 5) 0) (printf "Buzz\n")]
      [else (printf "~a\n" i)])))

(define (fizz-buzz-multithreaded n)
  (define fizz-thread (thread (lambda () (fizz n))))
  (thread-wait fizz-thread))

(fizz-buzz-multithreaded 15)