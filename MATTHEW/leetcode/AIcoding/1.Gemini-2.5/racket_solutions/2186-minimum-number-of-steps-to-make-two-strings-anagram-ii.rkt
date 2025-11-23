#lang racket

(define (min-steps s t)
  (define s-freq (make-vector 26 0))
  (define t-freq (make-vector 26 0))

  (define (char-to-idx c)
    (- (char->integer c) (char->integer #\a)))

  (for ([c (string->list s)])
    (define idx (char-to-idx c))
    (vector-set! s-freq idx (+ (vector-ref s-freq idx) 1)))

  (for ([c (string->list t)])
    (define idx (char-to-idx c))
    (vector-set! t-freq idx (+ (vector-ref t-freq idx) 1)))

  (define steps 0)
  (for ([i (in-range 26)])
    (define s-count (vector-ref s-freq i))
    (define t-count (vector-ref t-freq i))
    (when (> s-count t-count)
      (set! steps (+ steps (- s-count t-count)))))

  steps)