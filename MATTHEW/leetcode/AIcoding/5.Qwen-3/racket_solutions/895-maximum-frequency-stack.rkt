#lang racket

(define-struct stack (elements freq-map max-freq))

(define (make-max-frequency-stack)
  (make-stack (hash) (hash) 0))

(define (push stack x)
  (let* ([freq-map (stack-freq-map stack)]
         [current-freq (hash-ref freq-map x 0)]
         [new-freq (+ current-freq 1)])
    (set-box! (stack-elements stack) (cons x (hash-ref (stack-elements stack) new-freq '())))
    (set-box! (stack-freq-map stack) (hash-set freq-map x new-freq))
    (set-box! (stack-max-freq stack) (max (stack-max-freq stack) new-freq))))

(define (pop stack)
  (let* ([max-freq (stack-max-freq stack)]
         [elements (hash-ref (stack-elements stack) max-freq '())]
         [x (car elements)]
         [new-elements (cdr elements)])
    (set-box! (stack-elements stack) (hash-set (stack-elements stack) max-freq new-elements))
    (set-box! (stack-freq-map stack) (hash-update (stack-freq-map stack) x sub1))
    (when (null? new-elements)
      (set-box! (stack-max-freq stack) (sub1 max-freq)))
    x))