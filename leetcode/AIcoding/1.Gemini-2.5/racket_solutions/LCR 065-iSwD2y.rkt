#lang racket

(require math/sum)

(define (minimum-length-encoding words)
  (let* ([s (list->set words)]
         [mutable-s (box s)])
    (for-each (lambda (word)
                (for ([i (in-range 1 (string-length word))])
                  (let ([suffix (substring word i)])
                    (when (set-member? (unbox mutable-s) suffix)
                      (set-box! mutable-s (set-remove (unbox mutable-s) suffix))))))
              words)
    (let ([final-words (set->list (unbox mutable-s))])
      (+ (sum (map string-length final-words))
         (length final-words)))))