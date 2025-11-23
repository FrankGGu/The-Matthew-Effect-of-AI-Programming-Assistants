#lang racket

(define RangeSumQuery2D
  (class object%
    (define/override (init matrix)
      (define rows (length matrix))
      (define cols (if (zero? rows) 0 (length (first matrix))))
      (define prefix-sum (make-vector (+ 1 rows) (make-vector (+ 1 cols) 0)))
      (for ([i (in-range rows)])
        (for ([j (in-range cols)])
          (define current-sum (+ (vector-ref (vector-ref prefix-sum i) j) 
                                 (vector-ref (vector-ref matrix i) j)
                                 (vector-ref (vector-ref prefix-sum (add1 i)) j)
                                 (vector-ref (vector-ref prefix-sum i (add1 j)))
                                 (- (vector-ref (vector-ref prefix-sum (add1 i) (add1 j))))))
          (vector-set! (vector-ref prefix-sum (add1 i)) (add1 j) current-sum))))
      (set! this (new RangeSumQuery2D (vector->list prefix-sum))))

    (define/public (sum-region row1 col1 row2 col2)
      (define total-sum (- (vector-ref (vector-ref prefix-sum (add1 row2)) (add1 col2))
                           (vector-ref (vector-ref prefix-sum row1) (add1 col2))
                           (vector-ref (vector-ref prefix-sum (add1 row2)) col1)
                           (vector-ref (vector-ref prefix-sum row1 col1))))
      total-sum)))

(define (NumMatrix matrix)
  (new RangeSumQuery2D matrix))