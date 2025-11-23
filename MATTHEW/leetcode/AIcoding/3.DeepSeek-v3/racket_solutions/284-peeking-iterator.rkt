#lang racket

(define peeking-iterator%
  (class object%
    (super-new)

    (init-field [iterator #f])
    (field [peeked #f] [has-peeked #f])

    (define/public (peek)
      (if has-peeked
          peeked
          (begin
            (set! peeked (send iterator next))
            (set! has-peeked #t)
            peeked)))

    (define/public (next)
      (if has-peeked
          (begin0
            peeked
            (set! has-peeked #f)
            (set! peeked #f))
          (send iterator next)))

    (define/public (has-next)
      (or has-peeked (send iterator has-next)))))