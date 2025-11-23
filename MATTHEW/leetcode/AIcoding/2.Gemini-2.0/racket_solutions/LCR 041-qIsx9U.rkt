(define MovingAverage%
  (class object%
    (init size)
    (super-new)
    (define nums (make-vector size 0))
    (define sum 0)
    (define count 0)
    (define index 0)

    (define/public (next val)
      (if (< count size)
          (begin
            (vector-set! nums index val)
            (set! sum (+ sum val))
            (set! count (+ count 1))
            (set! index (+ index 1))
            (/ sum count))
          (begin
            (set! sum (- sum (vector-ref nums index)))
            (set! sum (+ sum val))
            (vector-set! nums index val)
            (set! index (+ index 1))
            (if (= index size) (set! index 0))
            (/ sum size))))

    ))