(define RangeFreqQuery
  (class object%
    (init arr)
    (super-new)
    (define freq (make-vector (add1 (apply max arr)) 0))
    (for ([num arr])
      (vector-set! freq num (add1 (vector-ref freq num))))
    (define/public (query left right value)
      (if (or (< right left) (< value 0) (>= value (vector-length freq)))
          0
          (- (vector-ref freq value) (if (< left 0) 0 (vector-ref freq value))))))
    (define/public (update index value)
      (let ([old (vector-ref arr index)])
        (vector-set! arr index value)
        (vector-set! freq old (sub1 (vector-ref freq old)))
        (vector-set! freq value (add1 (vector-ref freq value)))))))