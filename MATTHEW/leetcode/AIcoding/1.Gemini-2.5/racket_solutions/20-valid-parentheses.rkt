#lang racket

(define (is-valid s)
  (define stack '())
  (define char-map (hash #\) #\( #\] #\[ #\} #\{))

  (for ([char (in-string s)])
    (cond
      [(or (char=? char #\() (char=? char #\{) (char=? char #\[))
       (set! stack (cons char stack))]
      [(or (char=? char #\)) (char=? char #\}) (char=? char #\]))
       (when (empty? stack)
         (set! stack 'invalid-state)
         (break))
       (let ([top-char (car stack)])
         (set! stack (cdr stack))
         (unless (char=? top-char (hash-ref char-map char))
           (set! stack 'invalid-state)
           (break)))]
      [else
       (set! stack 'invalid-state)
       (break)]))

  (empty? stack))