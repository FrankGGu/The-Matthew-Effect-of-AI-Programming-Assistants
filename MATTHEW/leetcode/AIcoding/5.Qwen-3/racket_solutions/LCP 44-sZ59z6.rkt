#lang racket

(define (num-colors colors)
  (define (helper lst seen)
    (cond [(null? lst) (length seen)]
          [(member (car lst) seen) (helper (cdr lst) seen)]
          [else (helper (cdr lst) (cons (car lst) seen))]))
  (helper colors '()))

(define (max-beauty colors)
  (define (helper lst res)
    (cond [(null? lst) res]
          [else
           (let ([current (num-colors (car lst))])
             (if (> current res)
                 (helper (cdr lst) current)
                 (helper (cdr lst) res))))])
  (helper colors 0))

(define (solve)
  (let ([n (string->number (read-line))])
    (let loop ([i 0] [res 0])
      (if (= i n)
          res
          (let ([colors (map string->number (string-split (read-line)))]
                [k (string->number (read-line))])
            (loop (+ i 1) (max-beauty colors)))))))

(solve)