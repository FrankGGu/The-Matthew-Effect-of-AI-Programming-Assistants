#lang racket

(define (largest-variance s)
  (define n (string-length s))
  (define max-variance 0)

  (define (char-range start end)
    (for/list ([i (in-range (char->integer start) (add1 (char->integer end)))])
      (integer->char i)))

  (define alphabet (char-range #\a #\z))

  (for* ([char1 alphabet]
         [char2 alphabet])
    (when (not (char=? char1 char2))
      (define max-ending-here-with-char2 (- (+ n 1))) 
      (define max-ending-here-without-char2 0)

      (for ([i (in-range n)])
        (define current-char (string-ref s i))

        (define val 0)
        (when (char=? current-char char1) (set! val 1))
        (when (char=? current-char char2) (set! val -1))

        (define prev-max-ending-here-without-char2 max-ending-here-without-char2)

        (set! max-ending-here-with-char2 (+ max-ending-here-with-char2 val))
        (set! max-ending-here-without-char2 (+ max-ending-here-without-char2 val))

        (when (= val -1) 
          (set! max-ending-here-with-char2 (max max-ending-here-with-char2 (+ prev-max-ending-here-without-char2 val)))
          (set! max-ending-here-without-char2 0))

        (set! max-ending-here-without-char2 (max 0 max-ending-here-without-char2))

        (set! max-variance (max max-variance max-ending-here-with-char2))
        ))
  max-variance)