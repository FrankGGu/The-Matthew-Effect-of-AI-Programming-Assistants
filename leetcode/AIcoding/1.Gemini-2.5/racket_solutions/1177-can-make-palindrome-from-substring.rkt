#lang racket/base

(define (popcount n)
  (count identity (integer->list-of-bits n)))

(define (can-make-palindrome-from-substring s queries)
  (define s-len (string-length s))
  (define prefix-xor-masks (make-vector (+ s-len 1) 0))

  (for ([i (in-range s-len)])
    (define char-code (- (char->integer (string-ref s i)) (char->integer #\a)))
    (define prev-mask (vector-ref prefix-xor-masks i))
    (vector-set! prefix-xor-masks (+ i 1)
                 (bitwise-xor prev-mask (bitwise-arithmetic-shift-left 1 char-code))))

  (for/list ([query queries])
    (define left (first query))
    (define right (second query))
    (define k (third query))

    (define sub-mask (bitwise-xor (vector-ref prefix-xor-masks (+ right 1))
                                  (vector-ref prefix-xor-masks left)))
    (define odd-counts (popcount sub-mask))
    (define changes-needed (floor (/ odd-counts 2)))

    (<= changes-needed k)))