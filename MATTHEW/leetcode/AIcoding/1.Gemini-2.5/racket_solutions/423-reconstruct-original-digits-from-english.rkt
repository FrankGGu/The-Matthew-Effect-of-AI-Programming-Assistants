#lang racket

(define (original-digits s)
  (define char-counts (make-vector 26 0))

  (for ([c (string->list s)])
    (define idx (- (char->integer c) (char->integer #\a)))
    (vector-set! char-counts idx (+ (vector-ref char-counts idx) 1)))

  (define digit-counts (make-vector 10 0))

  (vector-set! digit-counts 0 (vector-ref char-counts (- (char->integer #\z) (char->integer #\a))))
  (vector-set! digit-counts 2 (vector-ref char-counts (- (char->integer #\w) (char->integer #\a))))
  (vector-set! digit-counts 4 (vector-ref char-counts (- (char->integer #\u) (char->integer #\a))))
  (vector-set! digit-counts 6 (vector-ref char-counts (- (char->integer #\x) (char->integer #\a))))
  (vector-set! digit-counts 8 (vector-ref char-counts (- (char->integer #\g) (char->integer #\a))))

  (vector-set! digit-counts 3
               (- (vector-ref char-counts (- (char->integer #\h) (char->integer #\a)))
                  (vector-ref digit-counts 8)))

  (vector-set! digit-counts 5
               (- (vector-ref char-counts (- (char->integer #\f) (char->integer #\a)))
                  (vector-ref digit-counts 4)))

  (vector-set! digit-counts 7
               (- (vector-ref char-counts (- (char->integer #\s) (char->integer #\a)))
                  (vector-ref digit-counts 6)))

  (vector-set! digit-counts 1
               (- (vector-ref char-counts (- (char->integer #\o) (char->integer #\a)))
                  (vector-ref digit-counts 0)
                  (vector-ref digit-counts 2)
                  (vector-ref digit-counts 4)))

  (vector-set! digit-counts 9
               (- (vector-ref char-counts (- (char->integer #\i) (char->integer #\a)))
                  (vector-ref digit-counts 5)
                  (vector-ref digit-counts 6)
                  (vector-ref digit-counts 8)))

  (define result-chars '())
  (for ([i (in-range 10)])
    (define digit-char (integer->char (+ (char->integer #\0) i)))
    (for ([_ (in-range (vector-ref digit-counts i))])
      (set! result-chars (cons digit-char result-chars))))

  (list->string (reverse result-chars)))