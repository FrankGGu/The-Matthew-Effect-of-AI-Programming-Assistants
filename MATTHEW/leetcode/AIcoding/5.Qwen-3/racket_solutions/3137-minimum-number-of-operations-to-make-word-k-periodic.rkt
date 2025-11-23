#lang racket

(define (minimum-operations word k)
  (define (count-freq s)
    (for/fold ([freq (hash)]) ([c (in-string s)])
      (hash-update freq c add1 0)))

  (define (get-substrings)
    (for/list ([i (in-range 0 (string-length word) k)])
      (substring word i (+ i k))))

  (define substrings (get-substrings))
  (define freq (count-freq substrings))
  (define max-count (apply max (hash-values freq)))
  (- (length substrings) max-count))