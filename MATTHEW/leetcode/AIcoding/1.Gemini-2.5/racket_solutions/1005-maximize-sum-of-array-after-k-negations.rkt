#lang racket

(define (maximize-sum-of-array-after-k-negations nums k)
  (let* ([len (length nums)]
         [arr (list->vector (sort nums <))])

    (let-values ([(stop-idx remaining-k)
                  (let loop ([i 0] [current-k k])
                    (cond
                      [(or (>= i len) (= current-k 0))
                       (values i current-k)]

                      [(< (vector-ref arr i) 0)
                       (vector-set! arr i (- (vector-ref arr i)))
                       (loop (+ i 1) (- current-k 1))]

                      [else
                       (values i current-k)]))])

      (when (and (> remaining-k 0) (odd? remaining-k))
        (let ([sorted-arr (list->vector (sort (vector->list arr) <))])
          (vector-set! sorted-arr 0 (- (vector-ref sorted-arr 0)))
          (set! arr sorted-arr)))

      (for/sum ([x (in-vector arr)]) x))))