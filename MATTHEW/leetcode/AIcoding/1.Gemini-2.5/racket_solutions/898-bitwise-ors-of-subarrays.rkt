#lang racket

(define (bitwise-ors-of-subarrays arr)
  (let ([all-ors (set)]
        [current-ors (set)])
    (for-each (lambda (num)
                (let ([next-ors (set num)])
                  (set-for-each current-ors
                                (lambda (x)
                                  (set! next-ors (set-add next-ors (bitwise-ior x num)))))

                  (set! all-ors (set-union all-ors next-ors))

                  (set! current-ors next-ors)))
              arr)
    (set-count all-ors)))