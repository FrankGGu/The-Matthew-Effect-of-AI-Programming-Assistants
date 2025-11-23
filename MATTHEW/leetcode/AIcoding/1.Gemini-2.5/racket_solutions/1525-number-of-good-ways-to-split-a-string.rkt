#lang racket

(define (num-good-splits s)
  (define n (string-length s))

  (when (<= n 1)
    (if (= n 1) 0 0))

  (define left-unique (make-vector n 0))
  (define seen-left (set))
  (for ([i (in-range n)])
    (set! seen-left (set-add seen-left (string-ref s i)))
    (vector-set! left-unique i (set-count seen-left)))

  (define right-unique (make-vector n 0))
  (define seen-right (set))
  (for ([i (range (- n 1) -1 -1)])
    (set! seen-right (set-add seen-right (string-ref s i)))
    (vector-set! right-unique i (set-count seen-right)))

  (define good-splits-count 0)
  (for ([i (in-range (- n 1))])
    (when (= (vector-ref left-unique i)
             (vector-ref right-unique (+ i 1)))
      (set! good-splits-count (+ good-splits-count 1))))

  good-splits-count)