#lang racket

(define (get-maximum-generated n)
  (cond
    [(zero? n) 0]
    [else
     (define nums (make-vector (+ n 1)))
     (vector-set! nums 0 0)
     (vector-set! nums 1 1)
     (define max-val 1)

     (for ([i (in-range 1 (add1 (quotient n 2)))])
       (let ([val-i (vector-ref nums i)])

         ; Calculate nums[2*i]
         (let ([idx-2i (* 2 i)])
           (when (<= idx-2i n)
             (vector-set! nums idx-2i val-i)
             (set! max-val (max max-val val-i))))

         ; Calculate nums[2*i + 1]
         (let ([idx-2i+1 (+ (* 2 i) 1)])
           (when (<= idx-2i+1 n)
             (let ([val-i+1 (vector-ref nums (add1 i))])
               (let ([new-val (+ val-i val-i+1)])
                 (vector-set! nums idx-2i+1 new-val)
                 (set! max-val (max max-val new-val))))))))
     max-val]))