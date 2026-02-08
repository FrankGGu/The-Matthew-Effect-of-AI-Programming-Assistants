#lang racket

(define (pseudo-palindromic-paths root)
  (define (dfs node freq)
    (if (null? node)
        0
        (let* ([val (car node)]
               [new-freq (bitwise-xor freq (arithmetic-shift 1 val))]
               [left (cadr node)]
               [right (caddr node)])
          (if (and (null? left) (null? right))
              (if (or (zero? new-freq) (zero? (bitwise-and new-freq (sub1 new-freq))))
                  1
                  0)
              (+ (dfs left new-freq) (dfs right new-freq))))))
  (dfs root 0))