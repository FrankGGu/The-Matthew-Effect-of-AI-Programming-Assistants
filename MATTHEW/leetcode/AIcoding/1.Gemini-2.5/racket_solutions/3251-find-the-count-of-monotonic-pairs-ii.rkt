#lang racket

(define (make-bit n)
  (make-vector (+ n 1) 0))

(define (bit-update! bit-arr idx delta)
  (let* ((n (vector-length bit-arr)))
    (let loop ((i idx))
      (when (< i n)
        (vector-set! bit-arr i (+ (vector-ref bit-arr i) delta))
        (loop (+ i (bitwise-and i (- i))))))))

(define (bit-query bit-arr idx)
  (let loop ((i idx) (sum 0))
    (if (zero? i)
        sum
        (loop (bitwise-and i (- i)) (+ sum (vector-ref bit-arr i))))))

(define (find-the-count-of-monotonic-pairs-ii nums)
  (let* ((n (vector-length nums)))
    (when (zero? n)
      0)

    (let* ((unique-sorted-values (sort (remove-duplicates (vector->list nums)) <))
           (val-to-rank (make-hash))
           (max-rank (sub1 (length unique-sorted-values))))
      (for-each (lambda (val rank)
                  (hash-set! val-to-rank val rank))
                unique-sorted-values
                (range 0 (length unique-sorted-values)))

      (let* ((bit-size (+ max-rank 1))
             (bit-arr (make-bit bit-size)))
        (let loop ((i (sub1 n)) (total-count 0))
          (if (< i 0)
              total-count
              (let* ((val (vector-ref nums i))
                     (rank (hash-ref val-to-rank val)))
                (let* ((count-greater-or-equal
                        (- (bit-query bit-arr bit-size)
                           (bit-query bit-arr rank))))
                  (bit-update! bit-arr (+ rank 1) 1)
                  (loop (sub1 i) (+ total-count count-greater-or-equal))))))))))