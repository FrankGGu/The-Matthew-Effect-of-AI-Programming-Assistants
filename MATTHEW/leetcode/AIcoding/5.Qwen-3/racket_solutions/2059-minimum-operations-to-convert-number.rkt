#lang racket

(define (minimum-operations target start a b)
  (define (bfs)
    (define visited (make-hash))
    (define q (queue))
    (enqueue! q (cons start 0))
    (hash-set! visited start #t)
    (let loop ()
      (when (not (queue-empty? q))
        (define current (dequeue! q))
        (define node (car current))
        (define steps (cdr current))
        (cond [(= node target) steps]
              [else
               (for-each (lambda (next)
                           (when (and (>= next 0) (not (hash-has-key? visited next)))
                             (hash-set! visited next #t)
                             (enqueue! q (cons next (+ steps 1)))))
                         (list (+ node a) (- node a) (+ node b) (- node b)))
               (loop)])))
    -1)
  (bfs))