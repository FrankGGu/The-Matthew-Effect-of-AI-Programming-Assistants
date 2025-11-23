#lang racket

(define (excellent-pairs nums)
  (define (count-ones n)
    (let loop ([n n] [count 0])
      (if (= n 0)
          count
          (loop (quotient n 2) (+ count (bitwise-and n 1))))))
  (define freq (make-hash))
  (for-each
   (lambda (x)
     (hash-update! freq (count-ones x) add1 0))
   nums)
  (define result 0)
  (for ([i (in-range 1 32)])
    (when (hash-has-key? freq i)
      (let ([cnt (hash-ref freq i)])
        (set! result (+ result (* cnt (- (hash-size freq) (if (> i 1) (hash-ref freq (- i 1) 0) 0))))))))
  result)