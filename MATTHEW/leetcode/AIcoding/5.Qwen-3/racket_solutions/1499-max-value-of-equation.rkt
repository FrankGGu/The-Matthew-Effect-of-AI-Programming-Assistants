#lang racket

(define (max-value-of-equation points k)
  (define (helper q i max-val)
    (if (>= i (length points))
        max-val
        (let* ([x (car (list-ref points i))]
               [y (cadr (list-ref points i))]
               [current (+ x y)])
          (let loop ([q q])
            (when (and (not (null? q)) (< (- (caar q) x) k))
              (set! q (cdr q))
              (loop q)))
          (if (null? q)
              (helper q (+ i 1) max-val)
              (helper (cons (list x y) q) (+ i 1) (max max-val (+ x y)))))))
  (helper '() 0 -inf.0))