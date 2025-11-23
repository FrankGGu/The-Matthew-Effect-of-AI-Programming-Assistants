#lang racket

(define (max-magic-chessboard grid)
  (define n (length grid))
  (define m (length (car grid)))

  (define max-ones 0)

  (for ([row-mask (in-range (expt 2 n))])
    (define current-total-ones 0)

    (for ([j (in-range m)])
      (define ones-if-Cj-0 0)

      (for ([i (in-range n)])
        (define R_i (if (logbit? i row-mask) 1 0))
        (define cell-val (list-ref (list-ref grid i) j))

        (when (= (xor cell-val R_i) 1)
          (set! ones-if-Cj-0 (+ ones-if-Cj-0 1))))

      (define ones-if-Cj-1 (- n ones-if-Cj-0))

      (set! current-total-ones (+ current-total-ones (max ones-if-Cj-0 ones-if-Cj-1))))

    (set! max-ones (max max-ones current-total-ones)))

  max-ones)