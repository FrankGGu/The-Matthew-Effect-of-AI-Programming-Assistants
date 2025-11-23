#lang racket

(define (trim s k)
  (substring s 0 k))

(define (cmp a b)
  (let* ((len-a (string-length a))
         (len-b (string-length b))
         (trim-a (trim a len-a))
         (trim-b (trim b len-b)))
    (if (not (= trim-a trim-b))
        (string<? trim-a trim-b)
        (< len-a len-b))))

(define (kthSmallest(nums k)
  (define trimmed-nums (map (lambda (num) (list num (trim (number->string num) k))) nums))
  (define sorted (sort trimmed-nums (lambda (x y) (cmp (second x) (second y)))))
  (car (first sorted)))

(define (kthSmallestTrimmedNumber nums k)
  (kthSmallest nums k))