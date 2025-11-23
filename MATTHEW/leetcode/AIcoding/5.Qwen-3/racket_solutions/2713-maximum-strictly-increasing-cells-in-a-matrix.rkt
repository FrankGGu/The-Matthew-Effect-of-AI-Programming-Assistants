#lang racket

(define (max-increasing-cells matrix)
  (define rows (length matrix))
  (define cols (length (car matrix)))
  (define dp (make-vector rows (make-vector cols 0)))
  (define cell-values (for/vector ([i rows]) (for/vector ([j cols]) (vector-ref (vector-ref matrix i) j))))
  (define sorted-cells
    (sort
     (for*/list ([i rows] [j cols]) (cons (vector-ref (vector-ref matrix i) j) (cons i j)))
     (lambda (a b) (< (car a) (car b)))))
  (define (get i j) (vector-ref (vector-ref dp i) j))
  (define (set! i j val) (vector-set! (vector-ref dp i) j val))
  (for ([cell sorted-cells])
    (define val (car cell))
    (define i (cadr cell))
    (define j (cddr cell))
    (define max-val 0)
    (when (> i 0) (set! max-val (max max-val (get (- i 1) j))))
    (when (> j 0) (set! max-val (max max-val (get i (- j 1)))))
    (set! i j (+ max-val 1)))
  (apply max (for*/list ([i rows] [j cols]) (get i j))))