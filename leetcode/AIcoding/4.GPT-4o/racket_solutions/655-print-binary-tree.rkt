#lang racket

(define (printBinaryTree root)
  (define (height node)
    (if (null? node) 0
        (max (+ 1 (height (send node left))) 
             (+ 1 (height (send node right))))))

  (define (fill result node row col height)
    (if (null? node) 
        (set! result (vector-set! result row col ""))
        (begin
          (set! result (vector-set! result row col (send node val)))
          (fill result (send node left) (+ row 1) (- col (expt 2 (- height row))))
          (fill result (send node right) (+ row 1) (+ col (expt 2 (- height row)))))))

  (define h (height root))
  (define width (expt 2 h))
  (define result (make-vector h (make-vector width "")))
  (fill result root 0 (sub1 (/ width 2)) h)
  (vector->list result))