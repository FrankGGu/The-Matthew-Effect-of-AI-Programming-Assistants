#lang racket

(define/contract (minimum-finish-time tires change-time num-laps)
  (-> (listof (listof exact-integer?)) exact-integer? exact-integer? exact-integer?)
  (let* ([max-laps 1000]
         [min-time (make-vector max-laps +inf.0)]
         [dp (make-vector (add1 num-laps) +inf.0)])
    (vector-set! dp 0 0)
    (for ([tire tires])
      (let ([f (first tire)]
            [r (second tire)])
        (let loop ([time f]
                   [lap 1]
                   [total-time 0])
          (when (and (<= lap max-laps)
                     (< time (* f (expt r lap))))
            (let ([new-total (+ total-time time)])
              (when (< new-total (vector-ref min-time (sub1 lap)))
                (vector-set! min-time (sub1 lap) new-total))
              (loop (* time r) (add1 lap) new-total))))))
    (for ([i (in-range 1 (add1 num-laps))])
      (for ([j (in-range 1 (add1 (min i max-laps)))])
        (vector-set! dp i (min (vector-ref dp i)
                               (+ (vector-ref dp (- i j))
                                  (vector-ref min-time (sub1 j))
                                  (if (= i j) 0 change-time))))))
    (vector-ref dp num-laps)))