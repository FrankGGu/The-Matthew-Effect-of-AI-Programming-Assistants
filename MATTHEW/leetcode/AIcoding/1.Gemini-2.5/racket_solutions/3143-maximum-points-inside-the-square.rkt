#lang racket

(define (maximum-points-inside-the-square points s)
  (define (get-thresholds points-list)
    (for/list ([p points-list])
      (let ([x (list-ref p 0)]
            [y (list-ref p 1)])
        (* 2 (max (abs x) (abs y))))))

  (define sorted-thresholds (sort (get-thresholds points) <))
  (define sorted-s (sort s <))

  (let loop ([t-list sorted-thresholds]
             [s-list sorted-s]
             [k 0])
    (cond
      [(or (empty? t-list) (empty? s-list)) k]
      [(> (car s-list) (car t-list))
       (loop (cdr t-list) (cdr s-list) (+ k 1))]
      [else
       (loop t-list (cdr s-list) k)])))