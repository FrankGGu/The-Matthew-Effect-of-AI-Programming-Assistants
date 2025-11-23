#lang racket

(define (rotate-string s goal)
  (if (equal? (string-length s) (string-length goal))
      (let ([double-s (string-append s s)])
        (string-contains? double-s goal))
      #f))

(define (string-contains? s substr)
  (let ([len (string-length substr)])
    (and (<= len (string-length s))
         (let loop ([i 0])
           (cond [(>= i (- (string-length s) len)) #f]
                 [(equal? (substring s i (+ i len)) substr) #t]
                 [else (loop (+ i 1))])))))