#lang racket

(define (find-subsequence-of-length-k-with-largest-sum nums k)
  (define indexed-nums
    (for/list ([val (in-list nums)]
               [idx (in-naturals)])
      (cons val idx)))

  (define sorted-by-value
    (sort indexed-nums
          (lambda (a b)
            (> (car a) (car b)))))

  (define top-k-elements
    (take sorted-by-value k))

  (define result-sorted-by-index
    (sort top-k-elements
          (lambda (a b)
            (< (cdr a) (cdr b)))))

  (map car result-sorted-by-index))