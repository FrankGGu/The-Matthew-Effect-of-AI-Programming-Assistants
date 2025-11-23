#lang racket

(define/public (zeroArrayTransformationII nums queries)
  (define n (length nums))
  (define nums-vec (list->vector nums))
  (define freq-map (make-hash))
  (define distinct-positive-count (box 0))
  (define results '())

  (for ([i (in-range n)])
    (define num (vector-ref nums-vec i))
    (when (> num 0)
      (when (= (hash-ref freq-map num 0) 0)
        (set-box! distinct-positive-count (+ (unbox distinct-positive-count) 1))))
    (hash-set! freq-map num (+ (hash-ref freq-map num 0) 1)))

  (for ([query queries])
    (define index (car query))
    (define val (cadr query))

    (define old-val (vector-ref nums-vec index))

    (hash-set! freq-map old-val (- (hash-ref freq-map old-val) 1))
    (when (> old-val 0)
      (when (= (hash-ref freq-map old-val) 0)
        (set-box! distinct-positive-count (- (unbox distinct-positive-count) 1))))

    (vector-set! nums-vec index val)

    (when (> val 0)
      (when (= (hash-ref freq-map val 0) 0)
        (set-box! distinct-positive-count (+ (unbox distinct-positive-count) 1))))
    (hash-set! freq-map val (+ (hash-ref freq-map val 0) 1))

    (set! results (cons (unbox distinct-positive-count) results)))

  (reverse results))