#lang racket

(require racket/set)

(define (get-key s)
  (let* ([len (string-length s)]
         [even-chars (for/list ([i (in-range len)]
                                [char (in-string s)]
                                #:when (even? i))
                       char)]
         [odd-chars (for/list ([i (in-range len)]
                               [char (in-string s)]
                               #:when (odd? i))
                      char)])
    (let* ([sorted-even (list->string (sort even-chars char<?))]
           [sorted-odd (list->string (sort odd-chars char<?))])
      (string-append sorted-even sorted-odd))))

(define (num-special-equiv-groups words)
  (let ([unique-keys (set)])
    (for ([word words])
      (set! unique-keys (set-add unique-keys (get-key word))))
    (set-count unique-keys)))