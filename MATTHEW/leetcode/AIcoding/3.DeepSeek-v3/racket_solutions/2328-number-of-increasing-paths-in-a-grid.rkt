#lang racket

(define (count-paths grid)
  (define m (length grid))
  (define n (if (zero? m) 0 (length (car grid))))
  (define dp (make-vector (* m n) -1))
  (define mod 1000000007)

  (define (dfs i j)
    (define idx (+ (* i n) j))
    (cond [(not (equal? (vector-ref dp idx) -1)) (vector-ref dp idx)]
          [else
           (define res 1)
           (for ([dir '((0 1) (1 0) (0 -1) (-1 0))])
             (define ni (+ i (car dir)))
             (define nj (+ j (cadr dir)))
             (when (and (>= ni 0) (< ni m) (>= nj 0) (< nj n)
                   (> ((list-ref (list-ref grid ni) nj) (list-ref (list-ref grid i) j))))
               (set! res (modulo (+ res (dfs ni nj)) mod))))
           (vector-set! dp idx res)
           res]))

  (define total 0)
  (for ([i (in-range m)])
    (for ([j (in-range n)])
      (set! total (modulo (+ total (dfs i j)) mod))))
  total)