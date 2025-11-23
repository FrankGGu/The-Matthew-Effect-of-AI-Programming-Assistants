#lang racket

(define (find-players-with-zero-or-one-losses matches)
  (define losses (make-hash))
  (for-each
   (lambda (match)
     (let ((player (car match)) (result (cadr match)))
       (hash-set! losses player (add1 (hash-ref losses player 0)))))
   matches)
  (filter
   (lambda (player) (<= (hash-ref losses player 0) 1))
   (remove-duplicates (apply append matches))))