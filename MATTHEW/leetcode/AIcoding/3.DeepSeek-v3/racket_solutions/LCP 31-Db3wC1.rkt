#lang racket

(define (escape-maze maze)
  (define rows (length maze))
  (define cols (if (zero? rows) 0 (length (car maze))))
  (define dirs '((0 . 1) (1 . 0) (0 . -1) (-1 . 0)))

  (define (valid? r c)
    (and (>= r 0) (< r rows) (>= c 0) (< c cols) (not (equal? (list-ref (list-ref maze r) c) '#')))))

  (define visited (make-hash))

  (define (dfs r c time)
    (cond
      [(equal? (list-ref (list-ref maze r) c) 'T) #t]
      [(hash-ref visited (list r c time) #f) #f]
      [else
       (hash-set! visited (list r c time) #t)
       (for/or ([dir dirs])
         (define nr (+ r (car dir)))
         (define nc (+ c (cdr dir)))
         (define nt (+ time 1))
         (if (valid? nr nc)
             (dfs nr nc nt)
             #f)))]))

  (for/or ([r (in-range rows)])
    (for/or ([c (in-range cols)])
      (and (equal? (list-ref (list-ref maze r) c) 'S)
           (dfs r c 0)))))