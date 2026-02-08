#lang racket

(require racket/list)

(define (get-max-num s)
  (let* ([s-list (string->list s)]
         [first-non-9 (find (lambda (c) (not (char=? c #\9))) s-list)])
    (if first-non-9
        (let ([new-s-list (map (lambda (c) (if (char=? c first-non-9) #\9 c)) s-list)])
          (string->number (list->string new-s-list)))
        (string->number s))))

(define (get-min-num s)
  (let* ([s-list (string->list s)]
         [first-char (car s-list)])
    (if (char=? first-char #\1)
        (let ([first-non-0-or-1 (find (lambda (c) (and (not (char=? c #\0)) (not (char=? c #\1)))) s-list)])
          (if first-non-0-or-1
              (let ([new-s-list (map (lambda (c) (if (char=? c first-non-0-or-1) #\0 c)) s-list)])
                (string->number (list->string new-s-list)))
              (string->number s)))
        (let ([new-s-list (map (lambda (c) (if (char=? c first-char) #\1 c)) s-list)])
          (string->number (list->string new-s-list))))))

(define (max-diff num)
  (let ([s (number->string num)])
    (- (get-max-num s) (get-min-num s))))