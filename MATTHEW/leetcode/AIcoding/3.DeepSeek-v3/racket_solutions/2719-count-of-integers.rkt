#lang racket

(define (count num1 num2 min_sum max_sum)
  (define (digit-dp s)
    (define n (string-length s))
    (define memo (make-hash))
    (define (helper pos tight sum)
      (if (>= pos n)
          (if (and (>= sum min_sum) (<= sum max_sum)) 1 0)
          (let ([key (list pos tight sum)])
            (if (hash-has-key? memo key)
                (hash-ref memo key)
                (let* ([limit (if tight (char->integer (string-ref s pos)) 9)]
                       [res (for/sum ([d (in-range 0 (add1 limit))])
                              (helper (add1 pos)
                                      (and tight (= d limit))
                                      (+ sum d)))])
                  (hash-set! memo key res)
                  res)))))
    (helper 0 #t 0))

  (- (digit-dp (number->string num2))
     (digit-dp (number->string (sub1 num1)))))