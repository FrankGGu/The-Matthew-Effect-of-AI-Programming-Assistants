#lang racket

(define (max-nesting-depth-two-valid-parentheses-strings seq)
  (let-values (((result-reversed final-depth)
                (for/fold ((acc-result '())
                           (current-depth 0))
                          ((char (in-string seq)))
                  (if (char=? char #\()
                      (values (cons (modulo current-depth 2) acc-result)
                              (+ current-depth 1))
                      ;; char is #\)
                      (values (cons (modulo (- current-depth 1) 2) acc-result)
                              (- current-depth 1))))))
    (reverse result-reversed)))