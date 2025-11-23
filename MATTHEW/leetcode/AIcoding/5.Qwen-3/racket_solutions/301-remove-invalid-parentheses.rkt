#lang racket

(define (remove-invalid-parentheses s)
  (define (is-valid? s)
    (define (helper s count)
      (cond [(null? s) (= count 0)]
            [(char=? #\() (helper (cdr s) (+ count 1))]
            [(and (char=? #\)) (> count 0)) (helper (cdr s) (- count 1))]
            [else #f]))
    (helper (string->list s) 0))

  (define (bfs s)
    (define (next-level level)
      (for/fold ([seen '()]
                 [next '()])
                ([str level])
        (if (member str seen)
            (values seen next)
            (let ([new-strings (for/list ([i (in-range (string-length str))])
                                 (string-append (substring str 0 i) (substring str (+ i 1))))])
              (values (cons str seen)
                      (append new-strings next))))))

    (define (loop queue seen)
      (cond [(null? queue) '()]
            [else
             (let ([current (car queue)])
               (if (is-valid? current)
                   (cons current (loop (cdr queue) seen))
                   (let-values ([(seen next) (next-level queue)])
                     (loop next seen))))]))

    (loop (list s) '()))

  (define result (bfs s))
  (if (null? result)
      '()
      result))