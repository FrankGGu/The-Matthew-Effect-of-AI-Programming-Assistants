#lang racket

(define (three-sum nums)
  (define sorted-vec (list->vector (sort nums <)))
  (define n (vector-length sorted-vec))
  (define results '())

  (for ([i (in-range (- n 2))])
    (when (> (vector-ref sorted-vec i) 0) (break))

    (when (or (= i 0) (not (= (vector-ref sorted-vec i) (vector-ref sorted-vec (- i 1)))))
      (define target (- (vector-ref sorted-vec i)))
      (define left (+ i 1))
      (define right (- n 1))

      (let loop ()
        (when (< left right)
          (define current-sum (+ (vector-ref sorted-vec left) (vector-ref sorted-vec right)))

          (cond
            [(= current-sum target)
             (set! results (cons (list (vector-ref sorted-vec i) (vector-ref sorted-vec left) (vector-ref sorted-vec right)) results))
             (set! left (+ left 1))
             (set! right (- right 1))
             (let skip-left-duplicates ()
               (when (and (< left right) (= (vector-ref sorted-vec left) (vector-ref sorted-vec (- left 1))))
                 (set! left (+ left 1))
                 (skip-left-duplicates)))
             (let skip-right-duplicates ()
               (when (and (< left right) (= (vector-ref sorted-vec right) (vector-ref sorted-vec (+ right 1))))
                 (set! right (- right 1))
                 (skip-right-duplicates)))
             (loop)]
            [(< current-sum target)
             (set! left (+ left 1))
             (loop)]
            [(> current-sum target)
             (set! right (- right 1))
             (loop)]))))
  (reverse results))