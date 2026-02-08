#lang racket

(define (maximum-jumps nums target)
  (define n (vector-length nums))
  (define dp (make-vector n -1))

  (vector-set! dp 0 0)

  (for ([i (in-range n)])
    (when (not (= (vector-ref dp i) -1))
      (for ([j (in-range (+ i 1) n)])
        (when (<= (abs (- (vector-ref nums i) (vector-ref nums j))) target)
          (vector-set! dp j (max (vector-ref dp j) (+ (vector-ref dp i) 1)))))))

  (vector-ref dp (- n 1)))