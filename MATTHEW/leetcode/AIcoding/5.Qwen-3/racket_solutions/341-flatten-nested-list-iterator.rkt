#lang racket

(define (flatten-nested-list-iterator nested-list)
  (define lst (reverse (flatten nested-list)))
  (define (has-next) (> (length lst) 0))
  (define (next) (let ((val (car lst))) (set! lst (cdr lst)) val))
  (lambda (method) (cond [(eq? method 'hasNext) has-next] [(eq? method 'next) next])))

(define (flatten lst)
  (cond [(null? lst) '()]
        [(list? (car lst)) (append (flatten (car lst)) (flatten (cdr lst)))]
        [else (cons (car lst) (flatten (cdr lst)))]))