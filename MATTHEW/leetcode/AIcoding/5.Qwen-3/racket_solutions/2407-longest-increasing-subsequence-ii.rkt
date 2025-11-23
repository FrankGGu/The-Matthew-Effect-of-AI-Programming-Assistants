#lang racket

(define (length-of-lis nums k)
  (define (update tree idx val)
    (let loop ([idx (add1 idx)])
      (when (<= idx (vector-length tree))
        (when (> val (vector-ref tree idx))
          (vector-set! tree idx val)
          (loop (+ (* 2 idx) -1))
          (loop (* 2 idx))))))

  (define (query tree idx)
    (let loop ([idx idx] [res 0])
      (if (< idx 1)
          res
          (loop (quotient idx 2) (max res (vector-ref tree idx))))))

  (define max-num (apply max nums))
  (define tree (make-vector (* 2 (expt 2 (floor (log (max 1 max-num) 2)))) 0))
  (for/fold ([res 0]) ([num nums])
    (define prev (query tree (sub1 num)))
    (update tree num (add1 prev))
    (max res (add1 prev))))

(define (main)
  (define input (read))
  (displayln (length-of-lis input 10000)))

(main)