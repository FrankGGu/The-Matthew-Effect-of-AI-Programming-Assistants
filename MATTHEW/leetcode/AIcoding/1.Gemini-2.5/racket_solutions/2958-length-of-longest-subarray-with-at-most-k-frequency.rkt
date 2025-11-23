#lang racket

(define (max-subarray-length nums k)
  (define n (vector-length nums))
  (define freq-map (make-hash))
  (define left 0)
  (define max-len 0)

  (for ([right (in-range n)])
    (define current-num (vector-ref nums right))

    (hash-set! freq-map current-num (+ (hash-ref freq-map current-num 0) 1))

    (let loop ()
      (when (> (hash-ref freq-map current-num) k)
        (define left-val (vector-ref nums left))
        (hash-set! freq-map left-val (- (hash-ref freq-map left-val) 1))
        (set! left (+ left 1))
        (loop)))

    (set! max-len (max max-len (+ (- right left) 1))))

  max-len)