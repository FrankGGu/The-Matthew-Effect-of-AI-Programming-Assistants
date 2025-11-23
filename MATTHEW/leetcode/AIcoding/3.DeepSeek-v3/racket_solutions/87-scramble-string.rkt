#lang racket

(define (is-scramble s1 s2)
  (define n (string-length s1))
  (define memo (make-hash))

  (define (helper s1 s2)
    (define key (cons s1 s2))
    (if (hash-has-key? memo key)
        (hash-ref memo key)
        (let ([result (let ([n (string-length s1)])
                         (cond
                           [(not (= n (string-length s2))) #f]
                           [(string=? s1 s2) #t]
                           [(not (equal? (sort (string->list s1) char<?)
                                         (sort (string->list s2) char<?))) #f]
                           [else
                            (for/or ([k (in-range 1 n)])
                              (or (and (helper (substring s1 0 k) (substring s2 0 k))
                                   (helper (substring s1 k) (substring s2 k)))
                              (and (helper (substring s1 0 k) (substring s2 (- n k)))
                                   (helper (substring s1 k) (substring s2 0 (- n k)))))]))])
          (hash-set! memo key result)
          result)))

  (helper s1 s2))