#lang racket

(define (three-sum nums)
  (let* ([n (length nums)]
         [sorted-vec (list->vector (sort nums <))])
    (define result '())

    (for ([i (in-range n)])
      (when (or (= i 0) (not (= (vector-ref sorted-vec i) (vector-ref sorted-vec (- i 1)))))
        (let ([target (- 0 (vector-ref sorted-vec i))]
              [left (+ i 1)]
              [right (- n 1)])

          (let loop ([l left] [r right])
            (when (< l r)
              (let ([current-sum (+ (vector-ref sorted-vec l) (vector-ref sorted-vec r))])
                (cond
                  [(= current-sum target)
                   (set! result (cons (list (vector-ref sorted-vec i) (vector-ref sorted-vec l) (vector-ref sorted-vec r)) result))
                   (let skip-l ([new-l (+ l 1)])
                     (if (and (< new-l r) (= (vector-ref sorted-vec new-l) (vector-ref sorted-vec (- new-l 1))))
                         (skip-l (+ new-l 1))
                         (let skip-r ([new-r (- r 1)])
                           (if (and (< new-l new-r) (= (vector-ref sorted-vec new-r) (vector-ref sorted-vec (+ new-r 1))))
                               (skip-r (- new-r 1))
                               (loop new-l new-r)))))]
                  [(< current-sum target)
                   (loop (+ l 1) r)]
                  [(> current-sum target)
                   (loop l (- r 1))])))))))
    (reverse result)))