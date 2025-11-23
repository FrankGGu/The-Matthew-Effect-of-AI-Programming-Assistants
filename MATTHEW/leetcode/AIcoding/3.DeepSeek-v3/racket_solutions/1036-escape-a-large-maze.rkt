#lang racket

(define (is-escape-possible blocked source target)
  (define max-steps 20000)
  (define blocked-set (for/set ([b blocked]) (cons (car b) (cadr b))))

  (define (bfs start end)
    (define visited (mutable-set))
    (define queue (mutable-list start))
    (set-add! visited start)
    (let loop ([steps 0])
      (cond
        [(null? queue) #f]
        [(> steps max-steps) #t]
        [(equal? (first queue) end) #t]
        [else
         (define current (first queue))
         (set-remove! queue current)
         (for ([dir '((0 1) (1 0) (0 -1) (-1 0))])
           (define x (+ (car current) (car dir)))
           (define y (+ (cdr current) (cadr dir)))
           (define next (cons x y))
           (when (and (>= x 0) (>= y 0) (< x 1000000) (< y 1000000)
                 (not (set-member? blocked-set next))
                 (not (set-member? visited next)))
             (set-add! visited next)
             (set-add! queue next)))
         (loop (add1 steps))])))

  (and (bfs (cons (car source) (cadr source)) (cons (car target) (cadr target)))
       (bfs (cons (car target) (cadr target)) (cons (car source) (cadr source)))))