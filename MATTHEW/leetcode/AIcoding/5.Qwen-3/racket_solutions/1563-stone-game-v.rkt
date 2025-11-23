#lang racket

(define (stone-game-v stone-lengths)
  (define len (length stone-lengths))
  (define dp (make-vector len (make-vector len 0)))
  (define prefix (make-vector len 0))
  (vector-set! prefix 0 (car stone-lengths))
  (for ([i (in-range 1 len)])
    (vector-set! prefix i (+ (vector-ref prefix (- i 1)) (list-ref stone-lengths i))))

  (for ([i (in-range len -1 -1)])
    (for ([j (in-range i len)])
      (when (= i j)
        (vector-set! (vector-ref dp i) j 0))
      (when (< i j)
        (let ([sum-left (vector-ref prefix (- j 1))]
              [sum-right (vector-ref prefix (- j 1))])
          (set! sum-right (- (vector-ref prefix (- j 1)) (vector-ref prefix i)))
          (let ([left (vector-ref (vector-ref dp i) (- j 1))]
                [right (vector-ref (vector-ref dp (- i 1) j)])
                [current (vector-ref (vector-ref dp i) j)])
            (if (< left right)
                (vector-set! (vector-ref dp i) j left)
                (vector-set! (vector-ref dp i) j right)))))))

  (vector-ref (vector-ref dp 0) (- len 1)))