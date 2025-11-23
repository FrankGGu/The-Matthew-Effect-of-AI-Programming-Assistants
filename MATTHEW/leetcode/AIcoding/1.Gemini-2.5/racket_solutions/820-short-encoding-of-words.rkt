#lang racket

(define (short-encoding-of-words words)
  (define word-set (list->set words))

  (for-each (lambda (word)
              (define len (string-length word))
              (when (> len 0) ; Only generate suffixes for non-empty words
                (for ([i (in-range 1 len)])
                  (define suffix (substring word i len))
                  (when (set-member? word-set suffix)
                    (set! word-set (set-remove word-set suffix))))))
            words)

  (apply + (map (lambda (word) (+ (string-length word) 1))
                (set->list word-set))))