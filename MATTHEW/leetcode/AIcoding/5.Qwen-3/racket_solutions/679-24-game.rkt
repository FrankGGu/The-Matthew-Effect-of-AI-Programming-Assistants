#lang racket

(define (find-possible-operations nums)
  (for*/list ([i (in-range (length nums))]
              [j (in-range (length nums))]
              #:when (not (= i j)))
    (list i j)))

(define (apply-operation a b op)
  (cond [(eqv? op '+) (+ a b)]
        [(eqv? op '-) (- a b)]
        [(eqv? op '*) (* a b)]
        [(eqv? op '/) (if (= b 0) #f (/ a b))]))

(define (solve nums)
  (define (helper remaining)
    (cond [(null? (cdr remaining)) (equal? (car remaining) 24)]
          [else
           (for/or ([i (in-range (length remaining))]
                    [j (in-range (length remaining))]
                    #:when (not (= i j)))
             (let* ([a (list-ref remaining i)]
                    [b (list-ref remaining j)]
                    [new-nums (append (take remaining i)
                                      (take-right remaining (- (length remaining) j 1))
                                      (drop-right remaining (- (length remaining) j 1)))]
                    [new-nums (append new-nums (list a b))])
               (for/or ([op '(+ - * /)])
                 (let ([result (apply-operation a b op)])
                   (and result (helper (append (take new-nums (sub1 i))
                                              (list result)
                                              (drop new-nums (add1 i)))))))))])
  (helper nums))

(define (game-24 nums)
  (solve nums))