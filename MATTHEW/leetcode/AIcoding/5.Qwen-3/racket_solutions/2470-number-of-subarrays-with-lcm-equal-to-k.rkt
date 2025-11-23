#lang racket

(define (lcm a b)
  (/ (* a b) (gcd a b)))

(define (subarray-lcm-equal-to-k nums k)
  (define n (length nums))
  (define result 0)
  (for ([i (in-range n)])
    (define current-lcm (list-ref nums i))
    (when (= current-lcm k)
      (set! result (+ result 1)))
    (for ([j (in-range (add1 i) n)])
      (set! current-lcm (lcm current-lcm (list-ref nums j)))
      (when (= current-lcm k)
        (set! result (+ result 1)))))
  result)