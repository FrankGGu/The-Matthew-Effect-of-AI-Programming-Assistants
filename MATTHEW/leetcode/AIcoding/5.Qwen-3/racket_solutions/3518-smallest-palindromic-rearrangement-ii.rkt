#lang racket

(define (smallest-palindromic-rearrangement s)
  (define freq (make-hash))
  (for-each (lambda (c) (hash-update! freq c add1)) (string->list s))
  (define odds (filter (lambda (k) (= (modulo (hash-ref freq k) 2) 1)) (hash-keys freq)))
  (define even-letters (for/fold ([res '()]) ([k (in-list (hash-keys freq))])
                         (append res (make-list (quotient (hash-ref freq k) 2) k))))
  (define odd-letter (if (null? odds) #f (car odds)))
  (define half (list->string (sort even-letters char<?)))
  (if (not odd-letter)
      (string-append half (reverse half))
      (string-append half (string (char->integer odd-letter)) (reverse half))))