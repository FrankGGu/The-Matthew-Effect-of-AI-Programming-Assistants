#lang racket

(define (check-sorted-rotated nums)
  (define n (length nums))
  (define (is-non-decreasing? lst)
    (cond [(null? lst) #t]
          [(null? (cdr lst)) #t]
          [else (and (<= (car lst) (cadr lst)) (is-non-decreasing? (cdr lst)))]))
  (define (rotate lst)
    (append (cdr lst) (list (car lst))))
  (let loop ([i 0] [lst nums])
    (if (= i n)
        #f
        (if (is-non-decreasing? lst)
            #t
            (loop (+ i 1) (rotate lst))))))