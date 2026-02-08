#lang racket

(define (subarraysWithKDistinct nums k)
  (- (count-at-most-k-distinct nums k)
     (count-at-most-k-distinct nums (- k 1))))

(define (count-at-most-k-distinct nums k)
  (let* ([n (vector-length nums)]
         [freq (make-hash)]
         [left 0]
         [ans 0])
    (for ([right (in-range n)])
      (let ([num-r (vector-ref nums right)])
        (hash-set! freq num-r (+ (hash-ref freq num-r 0) 1)))

      (let loop ()
        (when (> (hash-count freq) k)
          (let ([num-l (vector-ref nums left)])
            (hash-set! freq num-l (- (hash-ref freq num-l) 1))
            (when (= (hash-ref freq num-l) 0)
              (hash-remove! freq num-l)))
          (set! left (+ left 1))
          (loop)))

      (set! ans (+ ans (- right left -1))))
    ans))