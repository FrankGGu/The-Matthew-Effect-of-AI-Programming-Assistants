#lang racket

(define (valid-palindrome s)
  (let* ([len (string-length s)])
    (let loop ([left 0] [right (- len 1)])
      (cond
        [(>= left right) #t]
        [else
         (let* ([char-left (string-ref s left)]
                [char-right (string-ref s right)])
           (cond
             [(not (char-alphanumeric? char-left))
              (loop (+ left 1) right)]
             [(not (char-alphanumeric? char-right))
              (loop left (- right 1))]
             [else
              (if (char=? (char-downcase char-left) (char-downcase char-right))
                  (loop (+ left 1) (- right 1))
                  #f)]))]))))