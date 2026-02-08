#lang racket

(require racket/set)

(define (smallest-missing-integer nums)
  (let* ([n (vector-length nums)]
         [sps (vector-ref nums 0)])

    (for ([i (in-range 1 n)])
      (when (= (vector-ref nums i) (+ (vector-ref nums (- i 1)) 1))
        (set! sps (+ sps (vector-ref nums i))))
      (unless (= (vector-ref nums i) (+ (vector-ref nums (- i 1)) 1))
        (break)))

    (define seen-numbers (list->set (vector->list nums)))

    (let loop ([current-val sps])
      (if (set-member? seen-numbers current-val)
          (loop (+ current-val 1))
          current-val))))