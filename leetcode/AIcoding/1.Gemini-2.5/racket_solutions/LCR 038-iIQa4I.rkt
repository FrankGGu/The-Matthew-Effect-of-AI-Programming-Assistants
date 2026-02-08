#lang racket

(define (daily-temperatures temperatures)
  (define n (length temperatures))
  (define answer (make-vector n 0))
  (define stack '()) ; Stack stores (list index temperature)

  (for ([temp temperatures] [i (in-naturals)])
    (let loop ()
      (when (and (not (empty? stack))
                 (> temp (second (car stack))))
        (define top-item (car stack))
        (define prev-idx (first top-item))
        (set! stack (cdr stack))
        (vector-set! answer prev-idx (- i prev-idx))
        (loop)))
    (set! stack (cons (list i temp) stack)))

  (vector->list answer))