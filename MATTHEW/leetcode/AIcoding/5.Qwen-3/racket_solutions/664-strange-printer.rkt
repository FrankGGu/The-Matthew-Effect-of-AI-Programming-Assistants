#lang racket

(define (remove-duplicates lst)
  (cond [(null? lst) '()]
        [(member (car lst) (cdr lst)) (remove-duplicates (cdr lst))]
        [else (cons (car lst) (remove-duplicates (cdr lst)))]))

(define (strange-printer s)
  (define (dp i j)
    (cond [(> i j) 0]
          [(= i j) 1]
          [else
           (let ([res (if (= (string-ref s i) (string-ref s j))
                          (dp i (sub1 j))
                          (+ (dp i (sub1 j)) (dp (add1 j) j)))])
             (for/fold ([min-res res]) ([k (in-range i j)])
               (min min-res (+ (dp i k) (dp (add1 k) j))))))]))
  (dp 0 (sub1 (string-length s))))