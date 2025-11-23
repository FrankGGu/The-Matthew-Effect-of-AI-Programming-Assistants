#lang racket

(define (count-good-triplets arr by)
  (define len (length arr))
  (define count 0)
  (for ([i (in-range len)])
    (for ([j (in-range (+ i 1) len)])
      (for ([k (in-range (+ j 1) len)])
        (when (and (<= (abs (- (list-ref arr i) (list-ref arr j))) by)
                   (<= (abs (- (list-ref arr j) (list-ref arr k))) by)
                   (<= (abs (- (list-ref arr i) (list-ref arr k))) by))
          (set! count (+ count 1))))))
  count)