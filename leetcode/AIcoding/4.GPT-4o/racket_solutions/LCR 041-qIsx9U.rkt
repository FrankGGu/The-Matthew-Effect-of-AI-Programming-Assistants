#lang racket

(define MovingAverage
  (class object%
    (define/public (initialize size)
      (super-new)
      (set! max-size size)
      (set! sum 0)
      (set! queue (make-vector 0)))

    (define/public (next val)
      (vector-set! queue (vector-length queue) val)
      (set! sum (+ sum val))
      (if (> (vector-length queue) max-size)
          (begin
            (set! sum (- sum (vector-ref queue 0)))
            (set! queue (vector-map (lambda (x) x) (vector-slice queue 1 (vector-length queue)))))
          (void))
      (/ sum (min (vector-length queue) max-size)))

    (define max-size 0)
    (define sum 0)
    (define queue (void)))

  (define (make-moving-average size)
    (new MovingAverage [size size])))