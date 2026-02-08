#lang racket

(struct rectangle-queries (grid)
  #:methods
  ((define (updateSubrectangle self r1 c1 r2 c2 newValue)
     (for* ([r (range r1 (+ r2 1))]
            [c (range c1 (+ c2 1))])
       (vector-set! (vector-ref (rectangle-queries-grid self) r) c newValue)))

   (define (getValue self r c)
     (vector-ref (vector-ref (rectangle-queries-grid self) r) c))))