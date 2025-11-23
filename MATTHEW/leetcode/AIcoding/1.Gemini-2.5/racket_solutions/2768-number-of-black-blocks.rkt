#lang racket

(define (number-of-black-blocks m n coordinates)
  (define square-counts (make-hash))

  (define (add-to-square tr tc)
    (when (and (>= tr 0) (< tr (- m 1))
               (>= tc 0) (< tc (- n 1)))
      (hash-set! square-counts (list tr tc)
                 (+ 1 (hash-ref square-counts (list tr tc) 0)))))

  (for-each (lambda (coord)
              (define r (first coord))
              (define c (second coord))
              (add-to-square r c)
              (add-to-square r (- c 1))
              (add-to-square (- r 1) c)
              (add-to-square (- r 1) (- c 1)))
            coordinates)

  (define ans (make-vector 5 0))
  (define total-2x2-squares (* (- m 1) (- n 1)))

  (hash-for-each (lambda (key count)
                   (vector-set! ans count (+ 1 (vector-ref ans count)))
                   (set! total-2x2-squares (- total-2x2-squares 1)))
                 square-counts)

  (vector-set! ans 0 total-2x2-squares)

  (vector->list ans))