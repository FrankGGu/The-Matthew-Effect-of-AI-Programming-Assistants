#lang racket

(define RandomPickWithBlacklist%
  (class object%
    (init n blacklist)
    (define black-map (make-hash))
    (define m (sub1 (length blacklist)))
    (define valid-range (- n m))
    (for ([b blacklist])
      (hash-set! black-map b #t))
    (define (pick)
      (define idx (random n))
      (if (hash-has-key? black-map idx)
          (pick)
          idx))
    (define/public (pick-random)
      (if (< (random n) valid-range)
          (pick)
          (let ([idx (pick)])
            (if (hash-has-key? black-map idx)
                (pick)
                idx))))
    (super-new)))

(define (make-random-pick-with-blacklist n blacklist)
  (new RandomPickWithBlacklist% [n n] [blacklist blacklist]))