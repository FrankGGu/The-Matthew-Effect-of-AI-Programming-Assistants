#lang racket

(define (maxLength nums limit)
  (define sorted-nums (sort nums <))
  (define (helper nums limit count)
    (if (or (null? nums) (<= limit 0))
        count
        (let* ((first (car nums))
               (new-limit (- limit first)))
          (if (>= new-limit 0)
              (helper (cdr nums) new-limit (+ count 1))
              count))))
  (helper sorted-nums limit 0))

(define (longestSubsequence nums limit)
  (maxLength nums limit))