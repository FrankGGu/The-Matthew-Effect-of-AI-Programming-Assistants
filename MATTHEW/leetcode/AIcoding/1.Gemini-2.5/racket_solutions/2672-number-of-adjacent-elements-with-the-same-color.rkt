#lang racket

(define (number-of-adjacent-elements-with-the-same-color n queries)
  (define colors (make-vector n 0))
  (define current-same-color-pairs (box 0))
  (define results (box '()))

  (for-each
   (lambda (query)
     (define idx (car query))
     (define new-color (cadr query))
     (define old-color (vector-ref colors idx))

     (when (> idx 0)
       (define left-color (vector-ref colors (- idx 1)))
       (when (and (= left-color old-color) (> old-color 0))
         (set-box! current-same-color-pairs (sub1 (unbox current-same-color-pairs))))
       (when (and (= left-color new-color) (> new-color 0))
         (set-box! current-same-color-pairs (add1 (unbox current-same-color-pairs)))))

     (when (< idx (- n 1))
       (define right-color (vector-ref colors (+ idx 1)))
       (when (and (= right-color old-color) (> old-color 0))
         (set-box! current-same-color-pairs (sub1 (unbox current-same-color-pairs))))
       (when (and (= right-color new-color) (> new-color 0))
         (set-box! current-same-color-pairs (add1 (unbox current-same-color-pairs)))))

     (vector-set! colors idx new-color)

     (set-box! results (cons (unbox current-same-color-pairs) (unbox results))))
   queries)

  (reverse (unbox results)))