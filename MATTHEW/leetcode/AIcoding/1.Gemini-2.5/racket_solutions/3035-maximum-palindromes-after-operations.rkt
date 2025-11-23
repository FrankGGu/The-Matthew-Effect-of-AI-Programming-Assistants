#lang racket

(define (count-char-frequencies s)
  (define char-counts (make-hash))
  (for ([c (string->list s)])
    (hash-set! char-counts c (+ (hash-ref char-counts c 0) 1)))
  char-counts)

(define (get-odd-freq-count char-counts)
  (define odd-count 0)
  (hash-for-each char-counts
                 (lambda (char count)
                   (when (odd? count)
                     (set! odd-count (+ odd-count 1)))))
  odd-count)

(define (maximum-palindromes-after-operations words lengths)
  (define word-counts (make-hash))

  (for ([w words])
    (define len-w (string-length w))
    (define char-freqs (count-char-frequencies w))
    (define odd-freq-count (get-odd-freq-count char-freqs))

    (cond
      [(and (even? len-w) (= odd-freq-count 0))
       (hash-set! word-counts len-w (+ (hash-ref word-counts len-w 0) 1))]
      [(and (odd? len-w) (= odd-freq-count 1))
       (hash-set! word-counts len-w (+ (hash-ref word-counts len-w 0) 1))]))

  (define length-needs (make-hash))
  (for ([l lengths])
    (hash-set! length-needs l (+ (hash-ref length-needs l 0) 1)))

  (define max-palindromes 0)
  (for ([l (hash-keys length-needs)])
    (define needed-count (hash-ref length-needs l))
    (define available-words (hash-ref word-counts l 0))
    (set! max-palindromes (+ max-palindromes (min needed-count available-words))))

  max-palindromes)