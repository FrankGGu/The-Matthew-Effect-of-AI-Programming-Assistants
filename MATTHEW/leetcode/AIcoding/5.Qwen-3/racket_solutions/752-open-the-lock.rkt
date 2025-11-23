#lang racket

(define (open-lock deadends target)
  (define dead (set->hash (map (lambda (s) (string->list s)) deadends)))
  (define (neighbors node)
    (for/list ([i (in-range 4)]
               [d (in-range 10)])
      (let ([n (vector-copy node)])
        (vector-set! n i (modulo (+ (vector-ref n i) d) 10))
        n)))
  (define (bfs)
    (define queue (queue '(#(0 0 0 0))))
    (define visited (set (vector 0 0 0 0)))
    (let loop ()
      (when (not (queue-empty? queue))
        (let ([current (queue-front queue)])
          (queue-dequeue! queue)
          (if (equal? current (string->list target))
              (length (reverse (queue->list queue)))
              (begin
                (for-each
                 (lambda (next)
                   (when (and (not (hash-has-key? dead next))
                              (not (set-member? visited next)))
                     (set! visited (set-add visited next))
                     (queue-enqueue! queue next)))
                 (neighbors current))
                (loop)))))
    -1))
  (if (hash-has-key? dead #(0 0 0 0))
      -1
      (bfs)))