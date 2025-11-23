#lang racket

(define (count-characters words chars)
  (define (make-char-freq-map s)
    (define freq-map (make-hash))
    (for ([c (in-string s)])
      (hash-update! freq-map c add1 0))
    freq-map)

  (define (can-form-word? word-freq-map chars-freq-map)
    (for/all ([char (hash-keys word-freq-map)])
      (<= (hash-ref word-freq-map char) (hash-ref chars-freq-map char 0))))

  (define chars-freq-map (make-char-freq-map chars))

  (for/sum ([word words])
    (define word-freq-map (make-char-freq-map word))
    (if (can-form-word? word-freq-map chars-freq-map)
        (string-length word)
        0)))