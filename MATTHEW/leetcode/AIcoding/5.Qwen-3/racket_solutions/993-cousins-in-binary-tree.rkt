#lang racket

(define (is-cousins root x y)
  (define (find-level node val level)
    (cond
      [(null? node) #f]
      [(= (car node) val) (cons level #t)]
      [else
       (let ([left (find-level (cadr node) val (+ level 1))])
         (if (cdr left)
             left
             (find-level (caddr node) val (+ level 1))))]))

  (define (find-parent node val)
    (cond
      [(null? node) #f]
      [(or (= (car (cadr node)) val) (= (car (caddr node)) val)) (car node)]
      [else
       (let ([left (find-parent (cadr node) val)])
         (if left
             left
             (find-parent (caddr node) val)))]))

  (let* ([x-info (find-level root x 0)]
         [y-info (find-level root y 0)]
         [x-level (car x-info)]
         [y-level (car y-info)]
         [x-parent (find-parent root x)]
         [y-parent (find-parent root y)])
    (and (= x-level y-level) (not (= x-parent y-parent)))))