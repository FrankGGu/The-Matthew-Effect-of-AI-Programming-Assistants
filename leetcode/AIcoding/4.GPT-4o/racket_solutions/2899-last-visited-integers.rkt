#lang racket

(define (lastVisited(nums) k)
  (let loop ((n nums) (count 0) (result '()))
    (cond
      [(null? n) (reverse result)]
      [(> count k) (reverse result)]
      [else (loop (cdr n) (+ count 1) (cons (car n) result))]))))

(define (lastVisitedIntegers nums k)
  (lastVisited nums k))