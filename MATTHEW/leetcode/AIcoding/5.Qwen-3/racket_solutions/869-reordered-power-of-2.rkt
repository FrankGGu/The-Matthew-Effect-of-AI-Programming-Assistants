#lang racket

(define (get-counts n)
  (define (count-digits n m)
    (if (= n 0)
        m
        (count-digits (quotient n 10) (add1 m))))
  (define (digits n m)
    (if (= n 0)
        m
        (digits (quotient n 10) (cons (remainder n 10) m))))
  (let* ([len (count-digits n '())]
         [d (digits n '())])
    (map (lambda (x) (count (lambda (y) (= y x)) d)) (range 10))))

(define (reordered-power-of-2 n)
  (define (power-of-2? n)
    (and (not (= n 0))
         (= 1 (bitwise-and n (sub1 n)))))
  (define target (get-counts n))
  (for/first ([i (in-range 0 31)]
              #:when (power-of-2? (expt 2 i)))
    (equal? target (get-counts (expt 2 i))))
  #t)

(define (main)
  (define input (read))
  (displayln (reordered-power-of-2 input)))

(main)