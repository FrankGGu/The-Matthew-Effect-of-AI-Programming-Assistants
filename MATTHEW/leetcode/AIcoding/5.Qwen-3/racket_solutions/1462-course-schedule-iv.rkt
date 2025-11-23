#lang racket

(define (can-attack? a b)
  (let ([x1 (car a)] [y1 (cadr a)] [x2 (car b)] [y2 (cadr b)])
    (or (= x1 x2) (= y1 y2) (= (- x1 y1) (- x2 y2)) (= (+ x1 y1) (+ x2 y2)))))

(define (count-attacks positions)
  (define (helper i lst count)
    (if (null? lst)
        count
        (let ([current (car lst)])
          (helper (add1 i) (cdr lst) (+ count (length (filter (lambda (p) (can-attack? current p)) (take positions i))))))))
  (helper 0 positions 0))

(define (main)
  (define input (read))
  (display (count-attacks input)))

(main)