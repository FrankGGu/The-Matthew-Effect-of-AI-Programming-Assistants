#lang racket

(define-struct NumArray (n arr bit))

(define (fenwick-update! bit n idx delta)
  (let loop ((i (+ idx 1))) ; Convert 0-indexed to 1-indexed
    (when (<= i n)
      (vector-set! bit i (+ (vector-ref bit i) delta))
      (loop (+ i (bitwise-and i (- i)))))))

(define (fenwick-query bit idx)
  (let loop ((i (+ idx 1)) ; Convert 0-indexed to 1-indexed for prefix sum up to idx
             (sum 0))
    (if (> i 0)
        (loop (- i (bitwise-and i (- i)))
              (+ sum (vector-ref bit i)))
        sum)))

(define (NumArray-init nums)
  (let* ((n (vector-length nums))
         (arr (make-vector n))
         (bit (make-vector (+ n 1) 0)))

    (for ([i (in-range n)])
      (let ((val (vector-ref nums i)))
        (vector-set! arr i val)
        (fenwick-update! bit n i val)))

    (struct-instance NumArray n arr bit)))

(define (NumArray-update! self index val)
  (let* ((old-val (vector-ref (NumArray-arr self) index))
         (diff (- val old-val)))
    (vector-set! (NumArray-arr self) index val)
    (fenwick-update! (NumArray-bit self) (NumArray-n self) index diff)))

(define (NumArray-sumRange self left right)
  (- (fenwick-query (NumArray-bit self) right)
     (fenwick-query (NumArray-bit self) (- left 1))))