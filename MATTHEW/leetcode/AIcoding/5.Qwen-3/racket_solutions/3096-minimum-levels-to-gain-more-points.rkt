#lang racket

(define (min-levels-to-gain-more-points s)
  (define len (string-length s))
  (define-values (total-points left-points) (for/fold ([total 0] [left 0]) ([i (in-range len)])
                                              (if (= (string-ref s i) #\A)
                                                  (values (- total 1) (- left 1))
                                                  (values (+ total 1) (+ left 1)))))
  (define-values (current left) (for/fold ([current 0] [left 0]) ([i (in-range len)])
                                  (if (= (string-ref s i) #\A)
                                      (values (+ current 1) (- left 1))
                                      (values (+ current 1) (+ left 1)))
                                  (when (> left 0) (values current left))))
  (if (> left 0) current (add1 current)))