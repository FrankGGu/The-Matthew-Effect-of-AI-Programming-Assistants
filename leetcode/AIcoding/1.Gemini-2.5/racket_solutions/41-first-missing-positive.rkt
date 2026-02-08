#lang racket

(define/public (first-missing-positive nums)
  (let* ([n (length nums)]
         [v (list->vector nums)])

    (for ([i (in-range n)])
      (let loop ()
        (let ([val (vector-ref v i)])
          (when (and (> val 0)
                     (<= val n)
                     (not (= (vector-ref v (- val 1)) val)))
            (let ([target-idx (- val 1)])
              (vector-set! v i (vector-ref v target-idx))
              (vector-set! v target-idx val))
            (loop)))))

    (let find-missing ([i 0])
      (cond
        [(= i n) (+ n 1)]
        [(not (= (vector-ref v i) (+ i 1))) (+ i 1)]
        [else (find-missing (+ i 1))])))