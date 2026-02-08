#lang racket

(define (maximum-beauty nums k)
  (let* ([sorted-nums-list (sort nums <)]
         [n (length sorted-nums-list)])
    (if (zero? n)
        0
        (let* ([sorted-nums (list->vector sorted-nums-list)]
               [two-k (* 2 k)])
          (for/fold ([max-beauty 0]
                     [left 0])
                    ([right (in-range n)])
            (let ([current-right-val (vector-ref sorted-nums right)])
              (let find-valid-left ([current-left left])
                (if (<= (- current-right-val (vector-ref sorted-nums current-left)) two-k)
                    (values (max max-beauty (- right current-left -1))
                            current-left)
                    (find-valid-left (+ current-left 1))))))))))