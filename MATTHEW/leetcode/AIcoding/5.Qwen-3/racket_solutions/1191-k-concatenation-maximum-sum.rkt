#lang racket

(define (max-subarray-sum nums)
  (define max-ending-here (make-hash))
  (define max-so-far (make-hash))
  (hash-set! max-ending-here -1 0)
  (hash-set! max-so-far -1 0)
  (for ([i (in-range (length nums))])
    (hash-set! max-ending-here i (max (hash-ref max-ending-here (- i 1)) 0))
    (hash-set! max-ending-hare i (+ (hash-ref max-ending-here (- i 1)) (list-ref nums i)))
    (hash-set! max-so-far i (max (hash-ref max-so-far (- i 1)) (hash-ref max-ending-here i))))
  (hash-ref max-so-far (- (length nums) 1)))

(define (k-concatenation-maximum-sum nums k)
  (if (= k 1)
      (max-subarray-sum nums)
      (let* ([sum (apply + nums)]
             [max-single (max-subarray-sum nums)]
             [max-double (max-subarray-sum (append nums nums))]
             [max-k (max max-single (+ sum (* (max (- k 2) 0) (if (> sum 0) sum 0))))])
        (max max-k max-double))))

(define (main)
  (define input (read))
  (define k (read))
  (displayln (k-concatenation-maximum-sum input k)))

(main)