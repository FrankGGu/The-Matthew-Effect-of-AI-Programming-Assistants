#lang racket

(require data/heap)

(define (min-operations nums k)
  (let* ([h (list->heap nums)]
         [operations 0])
    (let loop ()
      (when (and (> (heap-count h) 1)
                 (< (heap-min h) k))
        (set! operations (+ operations 1))
        (let* ([min1 (heap-extract-min h)]
               [min2 (heap-extract-min h)]
               [new-val (+ (* min1 2) min2)])
          (heap-add h new-val))
        (loop)))
    operations))