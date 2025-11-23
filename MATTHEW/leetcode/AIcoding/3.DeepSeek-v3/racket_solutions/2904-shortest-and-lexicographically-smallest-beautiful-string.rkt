#lang racket

(define (shortest-beautiful-string s k)
  (define n (string-length s))
  (define min-len +inf.0)
  (define result "")

  (for ([i n])
    (define ones 0)
    (for ([j (in-range i n)])
      (when (char=? (string-ref s j) #\1)
        (set! ones (add1 ones)))
      (when (>= ones k)
        (define len (- j i -1))
        (cond
          [(< len min-len)
           (set! min-len len)
           (set! result (substring s i (+ j 1)))]
          [(= len min-len)
           (when (string<? (substring s i (+ j 1)) result)
           (set! result (substring s i (+ j 1)))]))))

  (if (string=? result "") "" result))