#lang racket

(define (max-repeating s)
  (if (string=? s "") 0
      (let loop ([i 1] [current-char (string-ref s 0)] [current-len 1] [max-len 1])
        (cond
          [(= i (string-length s)) max-len]
          [(char=? (string-ref s i) current-char)
           (loop (add1 i) current-char (add1 current-len) (max max-len (add1 current-len)))]
          [else
           (loop (add1 i) (string-ref s i) 1 (max max-len current-len))]))))