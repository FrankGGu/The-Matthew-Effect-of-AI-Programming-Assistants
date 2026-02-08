#lang racket

(require racket/vector)
(require racket/string)

(define (exclusive-time n logs)
  (define ans (make-vector n 0))
  (define stack '())
  (define prev-time 0)

  (for-each
   (lambda (log-str)
     (define parts (string-split log-str ":"))
     (define fn-id (string->number (list-ref parts 0)))
     (define type (list-ref parts 1))
     (define timestamp (string->number (list-ref parts 2)))

     (cond
       ((string=? type "start")
        (when (not (null? stack))
          (define top-fn-id (car stack))
          (vector-set! ans top-fn-id (+ (vector-ref ans top-fn-id) (- timestamp prev-time))))
        (set! stack (cons fn-id stack))
        (set! prev-time timestamp))

       ((string=? type "end")
        (define top-fn-id (car stack))
        (vector-set! ans top-fn-id (+ (vector-ref ans top-fn-id) (- timestamp prev-time) 1))
        (set! stack (cdr stack))
        (set! prev-time (+ timestamp 1))))))
   logs)

  (vector->list ans))