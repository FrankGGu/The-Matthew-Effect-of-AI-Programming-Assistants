#lang racket

(define (make-cell value)
  (let ([dependents '()]
        [dependencies '()]
        [value value])
    (lambda (msg . args)
      (cond
        [(eq? msg 'get-value) value]
        [(eq? msg 'set-value) (set! value (car args)) (for-each (lambda (d) (d 'update)) dependents)]
        [(eq? msg 'add-dependent) (set! dependents (cons (car args) dependents))]
        [(eq? msg 'add-dependency) (set! dependencies (cons (car args) dependencies))]
        [(eq? msg 'get-dependencies) dependencies]
        [(eq? msg 'update) (set! value (apply + (map (lambda (d) ((d 'get-value))) dependencies)))]))))

(define (make-spreadsheet)
  (let ([cells '()])
    (lambda (msg . args)
      (cond
        [(eq? msg 'cell) (let ([cell (make-cell (car args))]) (set! cells (cons cell cells)) cell)]
        [(eq? msg 'evaluate) (for-each (lambda (c) ((c 'update))) cells)]))))