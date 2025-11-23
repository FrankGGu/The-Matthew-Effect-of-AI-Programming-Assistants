#lang racket

(define (getPermutation n k)
  (define (factorial x)
    (if (= x 1) 1 (* x (factorial (- x 1)))))

  (define nums (map number->string (range 1 (+ n 1))))
  (define result "")
  (define k (- k 1)) ; Convert k to 0-indexed
  (define fact (factorial (- n 1)))

  (for ([i (range n)])
    (define index (quotient k fact))
    (set! result (string-append result (list-ref nums index)))
    (set! nums (remove* (list-ref nums index) nums))
    (set! k (remainder k fact))
    (when (> (- n i 1) 0)
      (set! fact (/ fact (- n i 1)))))

  result)

(define (main)
  (getPermutation 4 9))

(main)