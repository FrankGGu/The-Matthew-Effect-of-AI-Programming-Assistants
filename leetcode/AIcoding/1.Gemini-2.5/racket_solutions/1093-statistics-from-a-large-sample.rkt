#lang racket

(define (sample-statistics count)
  (let* ([total-count (for/sum ([c count]) c)]
         [total-sum (for/sum ([c count] [i (in-naturals)])
                      (* i c))]
         [min-val (box -1)]
         [max-val (box -1)]
         [mode-val (box -1)]
         [max-freq (box 0)])

    (for ([c count] [i (in-naturals)])
      (when (> c 0)
        (when (= (unbox min-val) -1)
          (set-box! min-val i))
        (set-box! max-val i)

        (when (> c (unbox max-freq))
          (set-box! max-freq c)
          (set-box! mode-val i))))

    (define mean (if (> total-count 0)
                     (/ (inexact total-sum) (inexact total-count))
                     0.0))

    (define median-val 0.0)
    (when (> total-count 0)
      (let ([current-count (box 0)]
            [median-idx1 (if (odd? total-count)
                             (ceiling (/ total-count 2))
                             (/ total-count 2))]
            [median-idx2 (if (odd? total-count)
                             (ceiling (/ total-count 2))
                             (+ (/ total-count 2) 1))]
            [found-val1 (box -1)]
            [found-val2 (box -1)])

        (for ([c count] [i (in-naturals)])
          (set-box! current-count (+ (unbox current-count) c))
          (when (and (= (unbox found-val1) -1) (>= (unbox current-count) median-idx1))
            (set-box! found-val1 i))
          (when (and (= (unbox found-val2) -1) (>= (unbox current-count) median-idx2))
            (set-box! found-val2 i)))

        (set! median-val (/ (+ (inexact (unbox found-val1)) (inexact (unbox found-val2))) 2.0))))

    (list (inexact (unbox min-val))
          (inexact (unbox max-val))
          mean
          median-val
          (inexact (unbox mode-val)))))