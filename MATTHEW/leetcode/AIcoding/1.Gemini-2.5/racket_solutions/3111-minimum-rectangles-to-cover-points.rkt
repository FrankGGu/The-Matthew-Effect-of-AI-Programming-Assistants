#lang racket

(require racket/vector)

(define (min-rectangles-to-cover-points points w)
  (let* ([sorted-points (vector-sort points (lambda (p1 p2) (< (vector-ref p1 0) (vector-ref p2 0))))]
         [n (vector-length sorted-points)])
    (let loop ([i 0]
               [rect-count 0])
      (if (>= i n)
          rect-count
          (let* ([current-point (vector-ref sorted-points i)]
                 [x-start (vector-ref current-point 0)]
                 [x-end (+ x-start w)])
            (let inner-loop ([j i])
              (if (and (< j n) (<= (vector-ref (vector-ref sorted-points j) 0) x-end))
                  (inner-loop (+ j 1))
                  (loop j (+ rect-count 1)))))))))