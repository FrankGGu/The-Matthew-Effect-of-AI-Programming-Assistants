#lang racket

(define (max-coin-points card-points k)
  (define n (length card-points))
  (define total (apply + card-points))
  (define window-size (- n k))
  (define first-window (take card-points window-size))
  (define initial-sum (apply + first-window))
  (define min-subarray-sum initial-sum)
  (define-values (current-sum _) 
    (for/fold ([sum initial-sum] [i 0]) ([j (in-range window-size n)])
      (define sum (+ sum (list-ref card-points j) (- (list-ref card-points (- i 1)))))
      (values sum (+ i 1))))
  (- total min-subarray-sum))

(define (main)
  (define input (map string->number (string-split (read-line))))
  (define k (string->number (read-line)))
  (displayln (max-coin-points input k)))

(main)