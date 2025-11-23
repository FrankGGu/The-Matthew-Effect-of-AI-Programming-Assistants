#lang racket

(define (word-break s word-dict)
  (define memo (make-hash))
  (define (helper s)
    (hash-ref memo s #f))
  (define (break-word s)
    (cond [(null? s) '(())]
          [else
           (for/fold ([res '()])
                     ([i (in-range 1 (add1 (string-length s)))]
                      #:when (member (substring s 0 i) word-dict))
             (append res
                     (for/list ([sub (in-list (break-word (substring s i)))])
                       (cons (substring s 0 i) sub))))]))
  (set! helper (lambda (s)
                 (if (hash-has-key? memo s)
                     (hash-ref memo s)
                     (let ([result (break-word s)])
                       (hash-set! memo s result)
                       result))))
  (if (null? (helper s)) '() (helper s)))