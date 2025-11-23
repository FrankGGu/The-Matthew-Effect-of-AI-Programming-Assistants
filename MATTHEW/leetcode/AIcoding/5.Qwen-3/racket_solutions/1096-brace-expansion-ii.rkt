#lang racket

(define (expand s)
  (define (helper s)
    (let loop ([s s] [res '()] [curr '()] [depth 0])
      (cond
        [(null? s) (if (null? curr) res (cons (list->string (reverse curr)) res))]
        [(char=? #\{ (car s))
         (loop (cdr s) res '() (+ depth 1))]
        [(char=? #\} (car s))
         (loop (cdr s) (cons (list->string (reverse curr)) res) '() (- depth 1))]
        [(and (char=? #\, (car s)) (= depth 0))
         (loop (cdr s) (cons (list->string (reverse curr)) res) '() depth)]
        [else
         (loop (cdr s) res (cons (car s) curr) depth)])))
  (define (combine lsts)
    (if (null? lsts)
        '("")
        (let ([first (car lsts)])
          (if (null? (cdr lsts))
              first
              (append-map (lambda (f) (map (lambda (s) (string-append f s)) (combine (cdr lsts)))) first)))))
  (define (parse s)
    (let loop ([s s] [res '()] [curr '()] [depth 0])
      (cond
        [(null? s) (if (null? curr) res (cons (list->string (reverse curr)) res))]
        [(char=? #\{ (car s))
         (let ([sub (parse (cdr s))])
           (loop (cdr (last sub)) res (append curr (list (car sub))) depth))]
        [(char=? #\} (car s))
         (loop (cdr s) res curr (- depth 1))]
        [(and (char=? #\, (car s)) (= depth 0))
         (loop (cdr s) (cons (list->string (reverse curr)) res) '() depth)]
        [else
         (loop (cdr s) res (cons (car s) curr) depth)])))
  (define (process s)
    (let ([parts (helper s)])
      (if (null? parts)
          '("")
          (combine (map (lambda (p) (if (string=? p "") '("") (list p))) parts)))))
  (sort (process s) string<?))