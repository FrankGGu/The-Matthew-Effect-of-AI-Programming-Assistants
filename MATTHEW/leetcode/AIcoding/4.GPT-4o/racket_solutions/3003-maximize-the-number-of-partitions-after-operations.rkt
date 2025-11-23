#lang racket

(define (maximizePartitions nums k)
  (define (can-partition? nums k)
    (define n (length nums))
    (define dp (make-vector (+ k 1) #f))
    (vector-set! dp 0 #t)
    (for ([i (in-range n)])
      (for ([j (in-range k (add1 (vector-ref dp (sub1 k)))) -1 -1])
        (when (and (vector-ref dp j) (>= (vector-ref nums i) j))
          (vector-set! dp (+ j (vector-ref nums i)) #t))))
    (for ([i (in-range k -1 -1)])
      (when (vector-ref dp i) (return i)))
    (vector-ref dp k))

  (define (count-partitions nums k)
    (define count 0)
    (for ([num nums])
      (when (<= num k)
        (set! count (add1 count))))
    count)

  (for ([i (in-range (add1 k))])
    (if (can-partition? nums i)
        (set! k i)))
  (count-partitions nums k))

(define (maxPartitions nums k)
  (maximizePartitions nums k))