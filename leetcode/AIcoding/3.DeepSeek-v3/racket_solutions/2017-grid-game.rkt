#lang racket

(define (grid-game grid)
  (let* ([row1 (car grid)]
         [row2 (cadr grid)]
         [n (length row1)]
         [prefix1 (make-vector n 0)]
         [prefix2 (make-vector n 0)])
  (for ([i (in-range n)])
    (vector-set! prefix1 i (+ (if (> i 0) (vector-ref prefix1 (- i 1)) 0) (list-ref row1 i)))
    (vector-set! prefix2 i (+ (if (> i 0) (vector-ref prefix2 (- i 1)) 0) (list-ref row2 i))))
  (let loop ([i 0] [res +inf.0])
    (if (>= i n)
        res
        (let ([option1 (- (vector-ref prefix1 (- n 1)) (vector-ref prefix1 i))]
              [option2 (if (> i 0) (vector-ref prefix2 (- i 1)) 0)])
          (loop (+ i 1) (min res (max option1 option2)))))))