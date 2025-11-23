#lang racket

(define (min-moves-to-pick-k-ones nums k)
  (define n (length nums))
  (define ones (for/list ([i (in-range n)] #:when (= 1 (list-ref nums i))) i))
  (define m (length ones))
  (if (< m k) -1
      (let loop ([i 0] [res +inf.0])
        (if (>= i (- m k)) res
            (let* ([left (list-ref ones i)]
                   [right (list-ref ones (+ i k -1))]
                   [mid (list-ref ones (+ i (quotient k 2)))]
                   [moves (abs (- mid left))])
              (loop (+ i 1) (min res moves)))))))