#lang racket
(require racket/set)

(define (flipgame fronts backs)
  (let ([bad-nums (make-set)]
        [min-good-num 2001])

    (for-each
     (lambda (f b)
       (when (= f b)
         (set! bad-nums (set-add bad-nums f))))
     fronts backs)

    (for-each
     (lambda (f b)
       (unless (set-member? bad-nums f)
         (set! min-good-num (min min-good-num f)))
       (unless (set-member? bad-nums b)
         (set! min-good-num (min min-good-num b))))
     fronts backs)
    min-good-num))