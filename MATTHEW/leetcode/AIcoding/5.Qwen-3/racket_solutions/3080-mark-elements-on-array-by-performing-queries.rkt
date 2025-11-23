#lang racket

(define (mark-elements nums queries)
  (define n (length nums))
  (define result (make-vector n #f))
  (define visited (make-hash))
  (for-each
   (lambda (q)
     (let ((val (car q))
           (index (cadr q)))
       (when (not (hash-has-key? visited val))
         (vector-set! result index #t)
         (hash-set! visited val #t))))
   queries)
  (vector->list result))