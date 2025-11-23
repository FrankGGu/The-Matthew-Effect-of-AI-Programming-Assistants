#lang racket

(define (license-key-formatting s key-length)
  (define (process-char c)
    (if (char-alphabetic? c)
        (char-downcase c)
        c))
  (define cleaned
    (string->list
     (string-join
      (filter (lambda (c) (not (char=? #\- c)))
              (map process-char (string->list s)))
      "")))
  (define (reverse-list lst)
    (foldl cons '() lst))
  (define (split-at lst n)
    (if (or (null? lst) (= n 0))
        (values '() lst)
        (let-values (((a b) (split-at (cdr lst) (- n 1))))
          (values (cons (car lst) a) b))))
  (define (format-helper lst result)
    (if (null? lst)
        (apply string-append (reverse result))
        (let-values (((chunk remaining) (split-at lst key-length)))
          (format-helper remaining (cons (list->string (reverse chunk)) result)))))
  (if (null? cleaned)
      ""
      (format-helper (reverse cleaned) '())))