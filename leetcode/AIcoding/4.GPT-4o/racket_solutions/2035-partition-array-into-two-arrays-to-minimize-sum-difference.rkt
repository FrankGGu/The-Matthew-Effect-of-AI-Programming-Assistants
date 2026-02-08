#lang racket

(define (minimizeSumDifference nums)
  (define total (apply + nums))
  (define n (length nums))
  (define half (quotient n 2))

  (define (helper i j sum)
    (if (= j half)
        (list sum)
        (if (= i n)
            '()
            (append (helper (add1 i) j sum)
                    (helper (add1 i) (add1 j) (+ sum (list-ref nums i)))))))

  (define sums (helper 0 0 0))
  (define min-diff (apply min (map (lambda (x) (abs (- (- total x) x))) sums)))
  min-diff)

(define (partitionArrayIntoTwoArrays nums)
  (minimizeSumDifference nums))