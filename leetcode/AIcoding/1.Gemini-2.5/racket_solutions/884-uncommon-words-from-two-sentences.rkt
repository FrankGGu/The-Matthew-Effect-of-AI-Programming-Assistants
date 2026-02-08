#lang racket

(define (uncommon-from-sentences s1 s2)
  (let* ((words1 (string-split s1 " "))
         (words2 (string-split s2 " "))
         (all-words (append words1 words2))
         (counts (make-hash)))

    (for-each (lambda (word)
                (hash-set! counts word (+ (hash-ref counts word 0) 1)))
              all-words)

    (filter (lambda (word)
              (= (hash-ref counts word) 1))
            (hash-keys counts))))