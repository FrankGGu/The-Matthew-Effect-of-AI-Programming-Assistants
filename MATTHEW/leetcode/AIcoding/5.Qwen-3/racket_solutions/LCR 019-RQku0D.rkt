#lang racket

(define (is-palindrome s left right)
  (let loop ([l left] [r right])
    (cond [(>= l r) #t]
          [(char=? (string-ref s l) (string-ref s r)) (loop (+ l 1) (- r 1))]
          [else #f])))

(define (valid-palindrome s)
  (let loop ([l 0] [r (- (string-length s) 1)] [count 0])
    (cond [(>= l r) #t]
          [(char=? (string-ref s l) (string-ref s r)) (loop (+ l 1) (- r 1) count)]
          [(< count 1)
           (or (loop (+ l 1) r (+ count 1))
               (loop l (- r 1) (+ count 1)))]
          [else #f])))