#lang racket

(define (closest-equal-element-queries nums queries)
  (define n (length nums))
  (define pos (make-hash))
  (for ([i (in-range n)]
        [x nums])
    (hash-update! pos x (λ (lst) (cons i lst)) '()))
  (define (query q)
    (define x (car q))
    (define idx (cadr q))
    (define lst (hash-ref pos x '()))
    (if (null? lst)
        -1
        (let loop ([lst lst]
                   [min-dist +inf.0]
                   [result -1])
          (if (null? lst)
              result
              (let ([d (abs (- (car lst) idx))])
                (if (< d min-dist)
                    (loop (cdr lst) d (car lst))
                    (loop (cdr lst) min-dist result)))))))
  (map query queries))