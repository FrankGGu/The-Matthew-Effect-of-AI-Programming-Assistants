#lang racket

(define (total-fruit fruits)
  (let* ([n (length fruits)]
         [max-fruits 0]
         [left 0]
         [fruit-counts (make-hash)])
    (for ([right (in-range n)])
      (let* ([current-fruit (list-ref fruits right)]
             [current-count (hash-ref fruit-counts current-fruit 0)])
        (hash-set! fruit-counts current-fruit (+ current-count 1)))

      (let loop ()
        (when (> (hash-count fruit-counts) 2)
          (let* ([left-fruit (list-ref fruits left)]
                 [left-count (hash-ref fruit-counts left-fruit)])
            (hash-set! fruit-counts left-fruit (- left-count 1))
            (when (= (hash-ref fruit-counts left-fruit) 0)
              (hash-remove! fruit-counts left-fruit))
            (set! left (+ left 1)))
          (loop)))

      (set! max-fruits (max max-fruits (- right left -1))))
    max-fruits))