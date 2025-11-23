#lang racket

(define (is-path-crossing path)
  (define visited (set #(#0 0)))
  (define directions (hash #\U #(0 1) #\D #(0 -1) #\R #(1 0) #\L #(-1 0)))
  (define (loop x y)
    (if (null? path)
        #f
        (let* ((d (hash-ref directions (car path)))
               (nx (+ x (vector-ref d 0)))
               (ny (+ y (vector-ref d 1)))
               (point (vector nx ny)))
          (if (set-member? visited point)
              #t
              (begin
                (set! visited (set-add visited point))
                (loop nx ny)))))
  (loop 0 0))