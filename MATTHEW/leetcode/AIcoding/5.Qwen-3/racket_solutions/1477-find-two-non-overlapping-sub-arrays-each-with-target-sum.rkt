#lang racket

(define (find-two-non-overlapping-sub-arrays-with-target-sum nums target)
  (define n (length nums))
  (define min-index (make-vector n #f))
  (define max-index (make-vector n #f))
  (define sum 0)
  (define start 0)
  (define i 0)
  (for ([j (in-range n)])
    (set! sum (+ sum (list-ref nums j)))
    (when (> sum target)
      (set! sum (- sum (list-ref nums start)))
      (set! start (add1 start)))
    (when (= sum target)
      (vector-set! min-index j j)
      (vector-set! max-index j start)))
  (let loop ([i 0] [min-val +inf.0] [min-pos -1])
    (cond [(= i n) min-pos]
          [(and (vector-ref min-index i) (<= i (vector-ref max-index i)))
           (loop (add1 i) (min min-val (vector-ref max-index i)) i)]
          [else (loop (add1 i) min-val min-pos)])))

(define (main)
  (define input (read))
  (define target (read))
  (displayln (find-two-non-overlapping-sub-arrays-with-target-sum input target)))

(main)