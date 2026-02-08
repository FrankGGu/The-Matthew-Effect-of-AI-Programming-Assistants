#lang racket

(define (apply-operations nums)
  (let* ([n (length nums)]
         [vec (list->vector nums)])

    (for ([i (in-range (- n 1))])
      (when (= (vector-ref vec i) (vector-ref vec (+ i 1)))
        (vector-set! vec i (* 2 (vector-ref vec i)))
        (vector-set! vec (+ i 1) 0)))

    (let loop ([i 0]
               [non-zeros '()]
               [zero-count 0])
      (if (= i n)
          (append (reverse non-zeros) (make-list zero-count 0))
          (let ([val (vector-ref vec i)])
            (if (= val 0)
                (loop (+ i 1) non-zeros (+ zero-count 1))
                (loop (+ i 1) (cons val non-zeros) zero-count)))))))