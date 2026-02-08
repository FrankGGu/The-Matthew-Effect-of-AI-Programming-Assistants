#lang racket

(require racket/set)

(define (longest-consecutive nums)
  (define num-set (list->set nums))
  (define max-length 0)

  (for-each (lambda (num)
              (when (not (set-contains? num-set (- num 1)))
                (define current-num num)
                (define current-length 1)

                (let loop ()
                  (when (set-contains? num-set (+ current-num 1))
                    (set! current-num (+ current-num 1))
                    (set! current-length (+ current-length 1))
                    (loop)))

                (set! max-length (max max-length current-length))))
            nums)

  max-length)