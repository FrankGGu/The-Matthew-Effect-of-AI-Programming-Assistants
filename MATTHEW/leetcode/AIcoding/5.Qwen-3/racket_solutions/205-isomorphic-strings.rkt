#lang racket

(define (is-isomorphic s t)
  (define (helper s t map1 map2)
    (cond [(and (empty? s) (empty? t)) #t]
          [(or (empty? s) (empty? t)) #f]
          [else
           (let ([char-s (car s)]
                 [char-t (car t)])
             (if (and (hash-has-key? map1 char-s) (hash-has-key? map2 char-t))
                 (and (equal? (hash-ref map1 char-s) char-t)
                      (equal? (hash-ref map2 char-t) char-s)
                      (helper (cdr s) (cdr t) map1 map2))
                 (and (not (hash-has-key? map1 char-s))
                      (not (hash-has-key? map2 char-t))
                      (helper (cdr s) (cdr t)
                              (hash-set map1 char-s char-t)
                              (hash-set map2 char-t char-s)))))]))
  (helper (string->list s) (string->list t) (hash) (hash)))