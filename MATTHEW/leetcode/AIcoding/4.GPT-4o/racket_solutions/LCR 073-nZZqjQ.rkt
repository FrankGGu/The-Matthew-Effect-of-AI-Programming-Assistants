#lang racket

(define (min-eating-speed piles H)
  (define (can-finish speed)
    (define total-hours  (apply + (map (lambda (p) (ceiling (/ p speed))) piles)))
    (<= total-hours H))

  (define (binary-search low high)
    (if (= low high)
        low
        (let* ((mid (quotient (+ low high) 2))
               (can-finish-mid (can-finish mid)))
          (if can-finish-mid
              (binary-search low mid)
              (binary-search (add1 mid) high)))))

  (binary-search 1 (apply max piles)))

(define (minEatingSpeed piles H)
  (min-eating-speed piles H))