#lang racket

(define (count-nice-pairs nums)
  (define (rev x)
    (let loop ([x x] [res 0])
      (if (zero? x)
          res
          (loop (quotient x 10) (+ (* res 10) (remainder x 10))))))
  (define freq (make-hash))
  (define res 0)
  (for ([num nums])
    (define key (- num (rev num)))
    (set! res (modulo (+ res (hash-ref freq key 0)) 1000000007))
    (hash-update! freq key add1 (lambda () 0)))
  res)