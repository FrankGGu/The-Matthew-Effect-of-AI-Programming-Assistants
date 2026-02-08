#lang racket

(define (reorder-list head)
  (define (find-middle node)
    (define slow node)
    (define fast node)
    (define prev #f)
    (while (and fast (cdr fast))
      (set! prev slow)
      (set! slow (cdr slow))
      (set! fast (cdr (cdr fast))))
    (when prev
      (set-cdr! prev #f))
    slow)

  (define (reverse-list node)
    (define prev #f)
    (define curr node)
    (while curr
      (define next (cdr curr))
      (set-cdr! curr prev)
      (set! prev curr)
      (set! curr next))
    prev)

  (define (merge l1 l2)
    (when l1
      (define next1 (cdr l1))
      (set-cdr! l1 l2)
      (when l2
        (define next2 (cdr l2))
        (set-cdr! l2 next1)
        (merge next1 next2)))

  (when head
    (define mid (find-middle head))
    (define l2 (reverse-list mid))
    (merge head l2)))

(define (list-to-string head)
  (if (null? head)
      ""
      (string-append (number->string (car head)) " " (list-to-string (cdr head)))))

(define (string-to-list str)
  (define lst (map string->number (string-split (string-trim str) " ")))
  (if (null? lst)
      '()
      (cons (car lst) (string-to-list (string-join (cdr lst) " ")))))

(define (reorder-list-string str)
  (define lst (string-to-list str))
  (define head (if (null? lst) #f (cons (car lst) (cdr lst))))
  (reorder-list head)
  (list-to-string head))