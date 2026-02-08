(define moving-average%
  (class object%
    (super-new)
    (init-field size)
    (define window (make-vector size 0))
    (define count 0)
    (define sum 0)
    (define ptr 0)

    (define/public (next val)
      (set! sum (+ sum val (- (vector-ref window ptr))))
      (vector-set! window ptr val)
      (set! ptr (modulo (add1 ptr) size))
      (if (< count size)
          (begin
            (set! count (add1 count))
            (/ sum count))
          (/ sum size))))

(define (make-moving-average size)
  (new moving-average% [size size]))