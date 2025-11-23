#lang racket

(define (find-indices nums indexDifference valueDifference)
  (define n (vector-length nums))

  (define min-val (vector-ref nums 0))
  (define min-idx 0)
  (define max-val (vector-ref nums 0))
  (define max-idx 0)

  (call-with-current-continuation
   (lambda (return)
     (for ([i (in-range indexDifference n)])
       (define k (- i indexDifference))

       (when (< (vector-ref nums k) min-val)
         (set! min-val (vector-ref nums k))
         (set! min-idx k))
       (when (> (vector-ref nums k) max-val)
         (set! max-val (vector-ref nums k))
         (set! max-idx k))

       (when (>= (abs (- (vector-ref nums i) min-val)) valueDifference)
         (return (list min-idx i)))
       (when (>= (abs (- (vector-ref nums i) max-val)) valueDifference)
         (return (list max-idx i))))

     (list -1 -1))))