#lang racket

(define (difference-of-distinct-values-on-diagonals grid)
  (define m (length grid))
  (define n (length (car grid))) ; Assumes grid is non-empty

  (define (get-distinct-count-tl r c)
    (define s (set))
    (let loop ((k 1))
      (define nr (- r k))
      (define nc (- c k))
      (if (and (>= nr 0) (>= nc 0))
          (begin
            (set! s (set-add s (list-ref (list-ref grid nr) nc)))
            (loop (+ k 1)))
          (set-count s))))

  (define (get-distinct-count-br r c)
    (define s (set))
    (let loop ((k 1))
      (define nr (+ r k))
      (define nc (+ c k))
      (if (and (< nr m) (< nc n))
          (begin
            (set! s (set-add s (list-ref (list-ref grid nr) nc)))
            (loop (+ k 1)))
          (set-count s))))

  (for/list ([r (in-range m)])
    (for/list ([c (in-range n)])
      (define distinct-tl (get-distinct-count-tl r c))
      (define distinct-br (get-distinct-count-br r c))
      (abs (- distinct-tl distinct-br)))))