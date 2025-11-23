#lang racket

(define (make-map)
  (let ((data '()))
    (lambda (cmd . args)
      (cond
        [(eqv? cmd 'insert) (set! data (cons (car args) data))]
        [(eqv? cmd 'sum) (apply + (filter (lambda (x) (>= x (cadr args))) data))]
        [else (error "unknown command")]))))

(define (main)
  (define map (make-map))
  (map 'insert 1)
  (map 'insert 2)
  (map 'insert 3)
  (map 'insert 4)
  (map 'insert 5)
  (map 'sum 3))

(main)