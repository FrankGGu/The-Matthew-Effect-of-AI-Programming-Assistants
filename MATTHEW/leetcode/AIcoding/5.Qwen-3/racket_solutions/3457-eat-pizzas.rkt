#lang racket

(define (eat-pizzas pizzas)
  (define (helper idx count)
    (cond [(>= idx (length pizzas)) count]
          [(= (vector-ref pizzas idx) 0) (helper (+ idx 1) count)]
          [else
           (let ([new-count (+ count 1)])
             (helper (+ idx 2) new-count))]))
  (helper 0 0))