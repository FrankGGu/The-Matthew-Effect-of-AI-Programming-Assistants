#lang racket

(define (maximize-win points k)
  (define points-vec (list->vector points))
  (define n (vector-length points-vec))

  (when (= n 0)
    0)

  (define dp-left (make-vector n 0))
  (define dp-right (make-vector n 0))

  (define left-ptr 0)
  (define max-points-so-far 0)
  (for ([i (in-range n)])
    (let ([current-point (vector-ref points-vec i)])
      (let loop-left ()
        (when (> (- current-point (vector-ref points-vec left-ptr)) k)
          (set! left-ptr (+ left-ptr 1))
          (loop-left)))
      (define current-segment-points (+ (- i left-ptr) 1))
      (set! max-points-so-far (max max-points-so-far current-segment-points))
      (vector-set! dp-left i max-points-so-far)))

  (define right-ptr (- n 1))
  (set! max-points-so-far 0)
  (for ([i (in-range (- n 1) -1 -1)])
    (let ([current-point (vector-ref points-vec i)])
      (let loop-right ()
        (when (> (- (vector-ref points-vec right-ptr) current-point) k)
          (set! right-ptr (- right-ptr 1))
          (loop-right)))
      (define current-segment-points (+ (- right-ptr i) 1))
      (set! max-points-so-far (max max-points-so-far current-segment-points))
      (vector-set! dp-right i max-points-so-far)))

  (define max-total 0)
  (when (> n 0)
    (set! max-total (vector-ref dp-left (- n 1))))

  (for ([i (in-range (- n 1))])
    (set! max-total (max max-total (+ (vector-ref dp-left i) (vector-ref dp-right (+ i 1))))))

  max-total)