#lang racket

(define (remove-duplicates s k)
  (define (helper stack count)
    (if (null? s)
        (apply string-append (map car stack))
        (let* ((char (string-ref s 0))
               (new-count (if (and (not (null? stack))
                                   (equal? char (car (car stack))))
                              (+ count (cdr (car stack)))
                              1)))
          (if (= new-count k)
              (helper (cdr stack) 0)
              (helper (cons (cons char new-count) (cdr stack)) 0)))))
  (helper '() 0))

(define (removeDuplicates s k)
  (remove-duplicates (string->list s) k))