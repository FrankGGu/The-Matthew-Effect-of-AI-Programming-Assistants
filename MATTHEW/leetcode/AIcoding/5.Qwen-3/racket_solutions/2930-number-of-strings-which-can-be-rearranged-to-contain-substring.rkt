#lang racket

(define (number-of-strings words)
  (define (contains-substring s)
    (let loop ([i 0])
      (cond [(>= i (- (string-length s) 1)) #f]
            [(and (char=? (string-ref s i) #\a)
                  (char=? (string-ref s (+ i 1)) #\b)
                  (char=? (string-ref s (+ i 2)) #\c))
             #t]
            [else (loop (+ i 1))])))
  (define (count s)
    (if (contains-substring s) 1 0))
  (apply + (map count words)))