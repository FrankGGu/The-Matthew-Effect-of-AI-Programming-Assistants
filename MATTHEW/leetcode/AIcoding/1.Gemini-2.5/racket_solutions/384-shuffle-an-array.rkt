#lang racket

(define-struct Solution (original-nums))

(define (Solution nums)
  (new-Solution (list->vector nums)))

(define (reset this)
  (vector->list (Solution-original-nums this)))

(define (shuffle this)
  (let* ([original-vec (Solution-original-nums this)]
         [n (vector-length original-vec)]
         [shuffled-vec (vector-copy original-vec)])
    (for ([i (range (- n 1) -1 -1)])
      (let* ([j (random (+ i 1))]
             [temp (vector-ref shuffled-vec i)])
        (vector-set! shuffled-vec i (vector-ref shuffled-vec j))
        (vector-set! shuffled-vec j temp)))
    (vector->list shuffled-vec)))