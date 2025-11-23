#lang racket

(define (eaten-apples apples baskets)
  (define (cmp a b)
    (< (car a) (car b)))
  (define (eat apples baskets)
    (cond [(null? apples) 0]
          [(and (null? baskets) (not (null? apples))) 0]
          [else
           (let* ([current (caar apples)]
                  [expire (cadar apples)]
                  [b (car baskets)])
             (if (<= current expire)
                 (begin
                   (set! apples (cdr apples))
                   (set! baskets (cons (cons (add1 current) (cadr b)) (cdr baskets)))
                   (+ 1 (eat apples baskets)))
                 (begin
                   (set! apples (cdr apples))
                   (eat apples baskets)))]))
  (define (process apples baskets)
    (if (null? apples)
        0
        (let ([current (caar apples)]
              [expire (cadar apples)])
          (if (and (not (null? baskets)) (<= current (caar baskets)))
              (begin
                (set! baskets (cons (cons (add1 current) (cadr (car baskets))) (cdr baskets)))
                (set! apples (cdr apples))
                (+ 1 (process apples baskets)))
              (begin
                (set! apples (cdr apples))
                (process apples baskets)))))
  (define (sort-baskets baskets)
    (if (null? baskets)
        '()
        (let ([min (apply min (map caar baskets))])
          (append (filter (lambda (x) (= (caar x) min)) baskets)
                  (sort-baskets (filter (lambda (x) (not (= (caar x) min))) baskets)))))
  (define (helper apples baskets)
    (if (null? apples)
        0
        (let ([current (caar apples)]
              [expire (cadar apples)])
          (if (and (not (null? baskets)) (<= current (caar baskets)))
              (begin
                (set! baskets (cons (cons (add1 current) (cadr (car baskets))) (cdr baskets)))
                (set! apples (cdr apples))
                (+ 1 (helper apples baskets)))
              (begin
                (set! apples (cdr apples))
                (helper apples baskets)))))
  (define (main apples baskets)
    (let ([sorted-apples (sort apples cmp)])
      (let ([sorted-baskets (sort-baskets baskets)])
        (helper sorted-apples sorted-baskets))))
  (main apples baskets))