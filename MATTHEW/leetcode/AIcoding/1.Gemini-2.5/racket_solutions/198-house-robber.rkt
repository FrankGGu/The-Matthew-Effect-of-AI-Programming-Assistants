#lang racket

(define (rob nums)
  (let ((n (length nums)))
    (cond
      ((zero? n) 0)
      ((= n 1) (car nums))
      (else
       (let* ((dp (make-vector n 0))
              (num-vec (list->vector nums)))

         (vector-set! dp 0 (vector-ref num-vec 0))

         (vector-set! dp 1 (max (vector-ref num-vec 0) (vector-ref num-vec 1)))

         (for ((i (in-range 2 n)))
           (vector-set! dp i
                        (max (+ (vector-ref num-vec i) (vector-ref dp (- i 2)))
                             (vector-ref dp (- i 1)))))

         (vector-ref dp (- n 1)))))))