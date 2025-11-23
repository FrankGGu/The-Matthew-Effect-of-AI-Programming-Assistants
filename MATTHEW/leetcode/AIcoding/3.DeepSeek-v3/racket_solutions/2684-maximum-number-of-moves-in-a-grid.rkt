#lang racket

(define (max-moves grid)
  (define rows (length grid))
  (define cols (if (null? grid) 0 (length (car grid))))
  (define dp (make-vector rows (make-vector cols 0)))
  (define max-moves 0)

  (for ([j (in-range (- cols 1) -1 -1)])
    (for ([i (in-range rows)])
      (define current-val (list-ref (list-ref grid i) j))
      (define next-moves 0)
      (for ([di (in-list '(-1 0 1))])
        (define ni (+ i di))
        (define nj (+ j 1))
        (when (and (>= ni 0) (< ni rows) (< nj cols))
          (define next-val (list-ref (list-ref grid ni) nj))
          (when (> next-val current-val)
            (set! next-moves (max next-moves (vector-ref (vector-ref dp ni) nj))))))
      (vector-set! (vector-ref dp i) j (if (= j (- cols 1)) 0 (+ next-moves 1)))
      (when (= j 0)
        (set! max-moves (max max-moves (vector-ref (vector-ref dp i) j)))))

  max-moves)