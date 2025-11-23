#lang racket

(define (occurrences-after-queries nums queries)
  (define (helper lst res)
    (if (null? lst)
        res
        (let ((num (car lst)))
          (helper (cdr lst) (append res (list (hash-ref (hash num) 'count 0)))))))
  (define (update-hash h num)
    (hash-set h num (+ 1 (hash-ref h num 0))))
  (define h (make-hash))
  (for-each (lambda (n) (set! h (update-hash h n))) nums)
  (helper nums '()))