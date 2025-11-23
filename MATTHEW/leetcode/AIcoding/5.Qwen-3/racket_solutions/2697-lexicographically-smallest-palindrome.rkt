#lang racket

(define (make-palindrome s)
  (define (helper left right)
    (cond [(>= left right) (list->string (reverse (append (take (string->list s) left) (drop (string->list s) right))))]
          [(char=? (string-ref s left) (string-ref s right)) (helper (+ left 1) (- right 1))]
          [else (let ([new-left (string-ref s left)]
                      [new-right (string-ref s right)])
                  (if (char<? new-left new-right)
                      (begin (set! s (string-set s right new-left)) (helper left (- right 1)))
                      (begin (set! s (string-set s left new-right)) (helper (+ left 1) right))))]))
  (helper 0 (- (string-length s) 1)))