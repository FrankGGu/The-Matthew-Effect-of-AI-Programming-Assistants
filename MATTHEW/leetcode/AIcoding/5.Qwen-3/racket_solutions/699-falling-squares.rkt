#lang racket

(define (falling-squares intervals)
  (define positions '())
  (define result '())
  (define (add-interval [start 0] [end 0] [height 0])
    (set! positions (cons (list start end height) positions)))
  (define (get-overlap a b)
    (let ([a-start (car a)]
          [a-end (cadr a)]
          [b-start (car b)]
          [b-end (cadr b)])
      (and (<= a-start b-end) (<= b-start a-end))))
  (define (get-max-height overlap-positions)
    (if (null? overlap-positions)
        0
        (apply max (map caddr overlap-positions))))
  (for-each
   (lambda (interval)
     (let ([start (car interval)]
           [end (+ (car interval) (cadr interval))])
       (let ([overlap-positions (filter (lambda (p) (get-overlap p (list start end))) positions)])
         (let ([new-height (+ (get-max-height overlap-positions) (cadr interval))])
           (add-interval start end new-height)
           (set! result (cons (list start end new-height) result))))))
   intervals)
  (reverse result))