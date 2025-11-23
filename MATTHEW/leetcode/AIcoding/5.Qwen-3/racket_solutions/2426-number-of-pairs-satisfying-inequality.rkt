#lang racket

(define (num-pairs nums)
  (define (count-nums x)
    (define (helper lst cnt)
      (cond [(null? lst) cnt]
            [(<= (- (car lst) x) 0) (helper (cdr lst) (+ cnt 1))]
            [else (helper (cdr lst) cnt)]))
    (helper nums 0))
  (define (loop i res)
    (if (>= i (length nums)) res
        (loop (+ i 1) (+ res (count-nums (list-ref nums i))))))
  (loop 0 0))