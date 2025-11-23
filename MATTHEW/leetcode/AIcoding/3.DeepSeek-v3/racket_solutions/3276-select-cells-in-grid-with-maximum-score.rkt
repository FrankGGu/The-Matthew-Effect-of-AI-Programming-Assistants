#lang racket

(define (max-score grid)
  (define m (length grid))
  (define n (if (null? grid) 0 (length (car grid))))
  (define dp (make-vector m (make-vector n 0)))
  (define (get-val i j)
    (if (or (< i 0) (< j 0))
        -inf.0
        (vector-ref (vector-ref dp i) j)))

  (for ([i (in-range m)])
    (for ([j (in-range n)])
      (define current (list-ref (list-ref grid i) j))
      (define up (get-val (- i 1) j))
      (define left (get-val i (- j 1)))
      (define diag (get-val (- i 1) (- j 1)))
      (define max-prev (max up left diag))
      (vector-set! (vector-ref dp i) j (+ current (if (equal? max-prev -inf.0) 0 max-prev)))))

  (vector-ref (vector-ref dp (- m 1)) (- n 1)))