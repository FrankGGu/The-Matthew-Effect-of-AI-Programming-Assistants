#lang racket

(define (longest-binary-subsequence-less-than-or-equal-to-k s k)
  (define (to-int str)
    (string->number str 2))

  (define (helper idx count)
    (if (>= idx (string-length s))
        count
        (let ([current (substring s idx (add1 idx))])
          (if (<= (to-int (string-append (make-string count #\0) current)) k)
              (helper (add1 idx) (add1 count))
              (helper (add1 idx) count)))))

  (helper 0 0))