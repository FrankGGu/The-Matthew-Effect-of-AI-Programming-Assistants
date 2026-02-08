#lang racket

(define (character-replacement s k)
  (define n (string-length s))
  (define char-counts (make-vector 26 0))
  (define left 0)
  (define max-freq 0)
  (define max-len 0)

  (for ([right (in-range n)])
    (define current-char (string-ref s right))
    (define char-idx (- (char->integer current-char) (char->integer #\A)))

    (vector-set! char-counts char-idx (+ (vector-ref char-counts char-idx) 1))

    (set! max-freq (max max-freq (vector-ref char-counts char-idx)))

    (when (> (- (+ right 1) left max-freq) k)
      (define left-char (string-ref s left))
      (define left-char-idx (- (char->integer left-char) (char->integer #\A)))
      (vector-set! char-counts left-char-idx (- (vector-ref char-counts left-char-idx) 1))
      (set! left (+ left 1)))

    (set! max-len (max max-len (- (+ right 1) left))))

  max-len)