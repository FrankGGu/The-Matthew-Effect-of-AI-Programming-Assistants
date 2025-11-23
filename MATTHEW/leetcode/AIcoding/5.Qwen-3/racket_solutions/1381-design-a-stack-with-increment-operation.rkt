#lang racket

(define (make-stack n)
  (let ((data '()))
    (lambda (op . args)
      (cond
        [(eq? op 'push) (set! data (cons (car args) data))]
        [(eq? op 'pop) (if (null? data) #f (let ((val (car data))) (set! data (cdr data)) val))]
        [(eq? op 'increment) (let ((k (car args)) (val (cadr args)))
                              (set! data (reverse (map (lambda (x i) (if (< i k) (+ x val) x)) (reverse data) (range (length data)))))])
        [else #f]))))