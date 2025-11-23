#lang racket

(define (nested-list? x)
  (list? x))

(define (make-nested-iterator nested-list)
  (let ((stack '())
        (current-list nested-list)
        (index 0))
    (lambda ()
      (let loop ()
        (if (>= index (length current-list))
            (if (null? stack)
                #f
                (let ((prev (car stack)))
                  (set! stack (cdr stack))
                  (set! current-list (car prev))
                  (set! index (cdr prev))
                  (loop)))
            (let ((element (list-ref current-list index)))
              (if (nested-list? element)
                  (begin
                    (set! stack (cons (cons current-list (add1 index)) stack))
                    (set! current-list element)
                    (set! index 0)
                    (loop))
                  (begin
                    (set! index (add1 index))
                    element))))))))

(define (flatten-nested-list nested-list)
  (let ((iterator (make-nested-iterator nested-list)))
    (let loop ((result '()))
      (let ((next (iterator)))
        (if next
            (loop (cons next result))
            (reverse result))))))

(define (nested-list-iterator nested-list)
  (let ((flattened (flatten-nested-list nested-list))
    (let ((current 0))
      (lambda (op)
        (case op
          ((hasNext) (< current (length flattened)))
          ((next) (begin0 (list-ref flattened current)
                          (set! current (add1 current))))))))

(define (nested-iterator? x)
  (procedure? x))

(define (has-next? iterator)
  (iterator 'hasNext))

(define (next iterator)
  (iterator 'next))

(define NestedIterator nested-list-iterator)