#lang racket

(define (num-alternating-groups s)
  (define (count-groups lst)
    (cond
      [(null? lst) 0]
      [(null? (cdr lst)) 1]
      [else
       (+ (if (not (= (car lst) (cadr lst))) 1 0)
          (count-groups (cdr lst)))]))
  (if (= (string-length s) 0)
      0
      (count-groups (map (lambda (c) (string->number (string c))) (string->list s)))))