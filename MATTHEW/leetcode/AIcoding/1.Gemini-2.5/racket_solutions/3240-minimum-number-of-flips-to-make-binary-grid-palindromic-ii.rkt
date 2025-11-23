#lang racket

(define (minimum-flips-to-make-binary-grid-palindromic-ii grid)
  (let* ([rows (length grid)]
         [cols (if (empty? grid) 0 (length (car grid)))])
    (cond
      [(or (zero? rows) (zero? cols)) 0]
      [else
       (let ([flips 0])
         (for ([r (in-range (ceiling (/ rows 2)))])
           (for ([c (in-range cols)])
             (let ([val1 (list-ref (list-ref grid r) c)]
                   [val2 (list-ref (list-ref grid (- rows 1 r)) (- cols 1 c))])
               (when (not (= val1 val2))
                 (set! flips (+ flips 1))))))
         flips)])))