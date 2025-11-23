#lang racket

(define (longest-subsequence nums limit)
  (define sorted (sort nums <))
  (define prefix (for/fold ([acc '()]) ([n sorted])
                   (if (null? acc)
                       (list n)
                       (cons (+ (car acc) n) acc))))
  (define len (length nums))
  (define (find idx)
    (cond [(= idx len) 0]
          [(<= (list-ref prefix idx) limit) (+ 1 (find (+ idx 1)))]
          [else 0]))
  (find 0))