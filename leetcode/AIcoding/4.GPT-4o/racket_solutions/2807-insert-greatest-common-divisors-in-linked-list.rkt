#lang racket

(define (insert-gcd linked-list)
  (define (gcd a b)
    (if (= b 0)
        a
        (gcd b (modulo a b))))

  (define (insert-gcd-aux node)
    (if (and node (cdr node))
        (let* ((next (cdr node))
               (g (gcd (car node) (car next)))
               (new-node (cons g '())))
          (set-cdr! new-node next)
          (set-cdr! node new-node)
          (insert-gcd-aux next))
        node))

  (insert-gcd-aux linked-list))