#lang racket/base

(define (count-pairs-of-similar-strings words)
  (let ([char-set-counts (make-hash)])
    (for-each
     (lambda (word)
       (let* ([chars (string->list word)]
              [sorted-chars (sort chars char<?)]
              [unique-sorted-chars (remove-duplicates sorted-chars)]
              [canonical-form (list->string unique-sorted-chars)])
         (hash-update! char-set-counts canonical-form (lambda (v) (+ v 1)) 0)))
     words)

    (let ([total-pairs 0])
      (hash-for-each
       (lambda (form count)
         (when (> count 1)
           (set! total-pairs (+ total-pairs (/ (* count (- count 1)) 2)))))
       char-set-counts)
      total-pairs)))