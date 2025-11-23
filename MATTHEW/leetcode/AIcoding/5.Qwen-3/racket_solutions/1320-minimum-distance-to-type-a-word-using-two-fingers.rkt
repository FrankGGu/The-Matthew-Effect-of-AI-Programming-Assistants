#lang racket

(define (minimum-distance word)
  (define (get-pos c)
    (let ([n (- (char->integer c) (char->integer #\A))])
      (values (quotient n 6) (remainder n 6))))

  (define (dist a b)
    (if (or (null? a) (null? b))
        0
        (+ (abs (- (car a) (car b))) (abs (- (cadr a) (cadr b))))))

  (define (dp i left right memo)
    (cond [(= i (string-length word)) 0]
          [(memq (cons left right) memo) (cdr (assq (cons left right) memo))]
          [else
           (let* ([c (string-ref word i)]
                  [pos (get-pos c)]
                  [d1 (dist pos left)]
                  [d2 (dist pos right)]
                  [new-memo (cons (cons left right) (cons d1 (dp (+ i 1) pos right (cons (cons left right) memo))))]
                  [new-memo2 (cons (cons left right) (cons d2 (dp (+ i 1) left pos (cons (cons left right) memo))))]
                  [res (min (car new-memo) (car new-memo2))])
             (cons res (cons (cons left right) memo)))]))

  (define initial-left '(0 0))
  (define initial-right '(0 0))
  (dp 0 initial-left initial-right '()))