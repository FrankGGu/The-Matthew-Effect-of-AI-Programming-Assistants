#lang racket

(define (maximum-alternating-subsequence-sum nums)
  (let-values (((even-sum odd-sum)
                (foldl (lambda (num acc)
                         (let-values (((prev-even prev-odd) acc))
                           (let ((next-even (max prev-even (+ prev-odd num)))
                                 (next-odd (max prev-odd (- prev-even num))))
                             (values next-even next-odd))))
                       (values 0 0)
                       nums)))
    (max even-sum odd-sum)))