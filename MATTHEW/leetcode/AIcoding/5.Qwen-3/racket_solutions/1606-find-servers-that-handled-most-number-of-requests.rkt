#lang racket

(define (find-servers-with-most-requests requests)
  (define n (length requests))
  (define m (length (car requests)))
  (define servers (make-vector m 0))
  (define (process-requests)
    (for ([i (in-range n)])
      (define req (list-ref requests i))
      (define time (car req))
      (define server-id (cadr req))
      (vector-set! servers server-id (+ (vector-ref servers server-id) 1))))
  (process-requests)
  (define max-count (apply max (vector->list servers)))
  (for/list ([i (in-range m)]
             #:when (= (vector-ref servers i) max-count))
    i))