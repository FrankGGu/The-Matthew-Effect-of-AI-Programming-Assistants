#lang racket

(define (open-lock deadends target)
  (define dead (list->set deadends))
  (define visited (mutable-set))
  (define queue (mutable-list))
  (define (next s)
    (for/list ([i (in-range 4)]
               [delta (in-list '(1 -1))])
      (define lst (string->list s))
      (define c (list-ref lst i))
      (define new-c (integer->char (+ (modulo (+ (char->integer c) (- 48 delta) 10) 48)))
      (list-set lst i new-c)))
  (define (bfs)
    (let loop ([steps 0])
      (if (null? queue)
          -1
          (let ([size (length queue)])
            (for ([_ (in-range size)])
              (define current (car queue))
              (set-remove! queue current)
              (cond
                [(equal? current target) steps]
                [(set-member? dead current) (void)]
                [(not (set-member? visited current))
                 (set-add! visited current)
                 (for ([n (next current)])
                   (set-add! queue n))])))
            (loop (add1 steps))))))
  (if (set-member? dead "0000")
      -1
      (begin
        (set-add! queue "0000")
        (bfs))))