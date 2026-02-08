#lang racket

(define (is-alien-sorted words order)
  (define order-map (make-hash))
  (for ([i (in-range (string-length order))]
        [c (in-string order)])
    (hash-set! order-map c i))

  (define (alien-compare w1 w2)
    (define len1 (string-length w1))
    (define len2 (string-length w2))
    (let loop ((i 0))
      (cond
        [(= i len1) ; w1 is exhausted, so w1 is a prefix of w2 or w1 == w2
         #t]
        [(= i len2) ; w2 is exhausted, but w1 is not, so w1 is longer and w2 is a prefix of w1
         #f]
        [else
         (define c1 (string-ref w1 i))
         (define c2 (string-ref w2 i))
         (define idx1 (hash-ref order-map c1))
         (define idx2 (hash-ref order-map c2))
         (cond
           [(< idx1 idx2) #t] ; c1 comes before c2
           [(> idx1 idx2) #f] ; c1 comes after c2
           [else (loop (+ i 1))])]))) ; characters are equal, continue to next

  (let loop ((words-list words))
    (cond
      [(or (null? words-list) (null? (cdr words-list)))
       #t]
      [else
       (define w1 (car words-list))
       (define w2 (cadr words-list))
       (if (alien-compare w1 w2)
           (loop (cdr words-list))
           #f)])))