#lang racket

(define (minimum-operations nums)
  (let* ([n (length nums)]
         [nums-vec (list->vector nums)])
    (if (<= n 1)
        0
        (let loop ([i (- n 2)]
                   [current-max-allowed (vector-ref nums-vec (- n 1))]
                   [total-operations 0])
          (if (< i 0)
              total-operations
              (let* ([current-num (vector-ref nums-vec i)])
                (if (<= current-num current-max-allowed)
                    (loop (- i 1)
                          current-num
                          total-operations)
                    (let* ([k (quotient (+ current-num current-max-allowed -1) current-max-allowed)]
                           [ops-for-this-num (- k 1)]
                           [new-current-max-allowed (quotient current-num k)])
                      (loop (- i 1)
                            new-current-max-allowed
                            (+ total-operations ops-for-this-num))))))))))