#lang racket

(define (can-win nums)
  (define (count-digits n)
    (define (helper n count)
      (if (= n 0)
          count
          (helper (quotient n 10) (+ count 1))))
    (helper n 0))
  (define (sum-digits n)
    (define (helper n sum)
      (if (= n 0)
          sum
          (helper (quotient n 10) (+ sum (remainder n 10)))))
    (helper n 0))
  (define (game-over? a b)
    (or (zero? a) (zero? b)))
  (define (play a b)
    (cond [(game-over? a b) #t]
          [(even? (sum-digits a)) (play (quotient a 10) b)]
          [(even? (sum-digits b)) (play a (quotient b 10))]
          [else #f]))
  (play nums nums))