#lang racket

(define (num-of-ways nums)
  (define mod 1000000007)
  (define (comb n k)
    (if (or (<= k 0) (>= k n)) 1
        (modulo (* (comb (sub1 n) (sub1 k)) n) (quotient k) mod)))

  (define (helper nums)
    (if (<= (length nums) 2) 1
        (let* ([root (car nums)]
               [left (filter (lambda (x) (< x root)) (cdr nums)]
               [right (filter (lambda (x) (> x root)) (cdr nums))]
               [lc (length left)]
               [rc (length right)]
               [left-ways (helper left)]
               [right-ways (helper right)]
               [total (comb (+ lc rc) lc)])
          (modulo (* total (modulo (* left-ways right-ways) mod)) mod))))

  (modulo (sub1 (helper nums)) mod))