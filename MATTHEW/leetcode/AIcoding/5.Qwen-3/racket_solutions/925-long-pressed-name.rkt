#lang racket

(define (valid-name name typed)
  (define (helper n t)
    (cond [(and (null? n) (null? t)) #t]
          [(null? n) #f]
          [(null? t) #f]
          [else
           (if (equal? (car n) (car t))
               (helper (cdr n) (cdr t))
               (if (equal? (car n) (car t))
                   (helper (cdr n) (cdr t))
                   #f))]))
  (let loop ([n name] [t typed] [prev #f])
    (cond [(and (null? n) (null? t)) #t]
          [(null? n) #t]
          [(null? t) #f]
          [else
           (if (equal? (car n) (car t))
               (loop (cdr n) (cdr t) (car t))
               (if (and prev (equal? prev (car t)))
                   (loop n (cdr t) prev)
                   #f))])))

(define/contract (is-long-pressed-name name typed)
  (-> string? string? boolean?)
  (valid-name (string->list name) (string->list typed)))