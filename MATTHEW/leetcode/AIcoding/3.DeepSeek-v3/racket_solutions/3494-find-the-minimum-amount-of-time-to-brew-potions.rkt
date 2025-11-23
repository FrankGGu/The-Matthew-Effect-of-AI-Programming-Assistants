#lang racket

(define (minimum-time potions k)
  (define n (length potions))
  (define (possible? time)
    (let loop ([potions potions] [count 0] [sum 0])
      (cond
        [(null? potions) (>= count k)]
        [else
         (let* ([p (car potions)]
                [new-sum (+ sum (quotient time p))])
           (if (>= new-sum k)
               #t
               (loop (cdr potions) new-sum new-sum)))])))
  (let binary-search ([left 1] [right (apply * potions k)])
    (if (= left right)
        left
        (let ([mid (quotient (+ left right) 2)])
          (if (possible? mid)
              (binary-search left mid)
              (binary-search (+ mid 1) right))))))