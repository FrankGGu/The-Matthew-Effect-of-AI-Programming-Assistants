#lang racket

(define (reconstruct-matrix (top) (bottom) (cnt))
  (define (count-ones lst)
    (for/sum ([b lst]) (if b 1 0)))
  (define (build-row c)
    (for/list ([i (length top)])
      (if (and (< (count-ones (take top i)) c) (not (list-ref bottom i))) #t #f)))
  (define row1 (build-row (car cnt)))
  (define row2 (build-row (cadr cnt)))
  (if (and (= (count-ones row1) (car cnt)) (= (count-ones row2) (cadr cnt)) (equal? (map + top bottom) (map + (map number->boolean row1) (map number->boolean row2)))) (list row1 row2) #f))