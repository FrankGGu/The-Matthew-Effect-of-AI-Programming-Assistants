#lang racket

(require math/matrix)

(define (minimum-operations grid)
  (let* ([m (matrix-num-rows grid)]
         [n (matrix-num-cols grid)]
         [dp (make-vector 10 0)]
         [new-dp (make-vector 10 0)]
         [counts (make-vector 10 0)])
    (for ([j (in-range n)])
      (for ([k (in-range 10)]) (vector-set! counts k 0))
      (for ([i (in-range m)])
        (let ([val (matrix-ref grid i j)])
          (vector-set! counts val (add1 (vector-ref counts val)))))
      (for ([k (in-range 10)])
        (vector-set! new-dp k +inf.0)
        (for ([prev (in-range 10)])
          (when (not (= prev k))
            (vector-set! new-dp k (min (vector-ref new-dp k)
                                      (+ (vector-ref dp prev)
                                         (- m (vector-ref counts k)))))))
      (set! dp (vector-copy new-dp)))
    (apply min (vector->list dp))))