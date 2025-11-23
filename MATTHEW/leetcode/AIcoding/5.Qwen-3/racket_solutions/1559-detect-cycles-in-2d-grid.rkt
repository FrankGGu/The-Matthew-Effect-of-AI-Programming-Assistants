#lang racket

(define (has-cycle grid)
  (define rows (length grid))
  (define cols (if (null? grid) 0 (length (car grid))))
  (define visited (make-hash))

  (define (dfs r c parent-r parent-c color)
    (cond
      [(or (< r 0) (>= r rows) (< c 0) (>= c cols)) #f]
      [(equal? (hash-ref visited (cons r c) #f) color) #t]
      [(equal? (hash-ref visited (cons r c) #f) 'visited) #f]
      [else
       (hash-set! visited (cons r c) color)
       (define up (and (not (= r parent-r)) (dfs (- r 1) c r c color)))
       (define down (and (not (= r parent-r)) (dfs (+ r 1) c r c color)))
       (define left (and (not (= c parent-c)) (dfs r (- c 1) r c color)))
       (define right (and (not (= c parent-c)) (dfs r (+ c 1) r c color)))
       (or up down left right)]))

  (for*/or ([r (in-range rows)]
            [c (in-range cols)])
    (when (not (hash-has-key? visited (cons r c)))
      (dfs r c -1 -1 (cons r c)))))