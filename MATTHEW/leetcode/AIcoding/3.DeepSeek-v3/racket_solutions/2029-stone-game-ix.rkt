#lang racket

(define (stone-game-ix stones)
  (let* ([counts (make-vector 3 0)]
         [sum 0])
    (for ([stone (in-list stones)])
      (let ([r (modulo stone 3)])
        (vector-set! counts r (add1 (vector-ref counts r)))))
    (let ([c0 (vector-ref counts 0)]
          [c1 (vector-ref counts 1)]
          [c2 (vector-ref counts 2)])
      (if (even? c0)
          (or (> c1 0) (> c2 0))
          (> (abs (- c1 c2)) 2)))))