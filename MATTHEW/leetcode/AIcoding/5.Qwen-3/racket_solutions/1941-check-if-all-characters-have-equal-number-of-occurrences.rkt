#lang racket

(define (are-equal? lst)
  (define (helper lst val)
    (cond [(null? lst) #t]
          [(equal? (car lst) val) (helper (cdr lst) val)]
          [else #f]))
  (helper (cdr lst) (car lst)))

(define (unique-counts s)
  (define counts (make-hash))
  (for ([c (in-string s)])
    (hash-set! counts c (+ 1 (hash-ref counts c 0))))
  (hash-values counts))

(define/contract (are-equal-occurrences s)
  (-> string? boolean?)
  (are-equal? (unique-counts s)))