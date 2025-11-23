#lang racket

(require racket/set)

(define (longest-word words)
  (define sorted-words (sort words string<?))

  (define-values (final-longest-word final-valid-prefix-set)
    (for/fold ([longest-word-found ""]
               [valid-prefix-set (set "")])
              ([word sorted-words])
      (define prefix (substring word 0 (max 0 (- (string-length word) 1))))

      (if (set-contains? valid-prefix-set prefix)
          (values (if (> (string-length word) (string-length longest-word-found))
                      word
                      longest-word-found)
                  (set-add valid-prefix-set word))
          (values longest-word-found
                  valid-prefix-set))))
  final-longest-word)