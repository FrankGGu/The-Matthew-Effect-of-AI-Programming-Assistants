#lang racket

(define (smallest-palindromic-rearrangement s)
  (define freq (make-hash))
  (for ([c s])
    (hash-set! freq c (+ 1 (hash-ref freq c 0))))

  (define odd-char #f)
  (define even-chars '())

  (for ([c (in-list (hash-keys freq))])
    (define cnt (hash-ref freq c))
    (if (even? cnt)
        (set! even-chars (append even-chars (make-list (/ cnt 2) c)))
        (begin
          (set! odd-char c)
          (set! even-chars (append even-chars (make-list (/ (- cnt 1) 2) c))))))

  (define half (string (apply append even-chars)))
  (define half-rev (string (reverse (string->list half))))

  (if odd-char
      (string-append half (string odd-char) half-rev)
      (string-append half half-rev)))