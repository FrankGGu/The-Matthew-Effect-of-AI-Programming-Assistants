#lang racket

(define (min-booths words)
  (define (char->idx c)
    (- (char->integer c) (char->integer #\a)))

  (define (idx->char i)
    (integer->char (+ i (char->integer #\a))))

  (define global-max-freq (make-vector 26 0))

  (for-each (lambda (word)
              (define word-freq (make-vector 26 0))
              (for ([c (in-string word)])
                (define idx (char->idx c))
                (vector-set! word-freq idx (+ (vector-ref word-freq idx) 1)))

              (for ([i (in-range 26)])
                (vector-set! global-max-freq i
                             (max (vector-ref global-max-freq i)
                                  (vector-ref word-freq i)))))
            words)

  (define result-chars '())
  (for ([i (in-range 26)])
    (define char-to-add (idx->char i))
    (define count (vector-ref global-max-freq i))
    (for ([_ (in-range count)])
      (set! result-chars (cons char-to-add result-chars))))

  (list->string (reverse result-chars)))