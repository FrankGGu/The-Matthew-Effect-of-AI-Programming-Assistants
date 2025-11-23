#lang racket

(define (replace-elements nums)
  (let ((n (length nums)))
    (let loop ((i (- n 2)) (max-val (last nums)))
      (if (< i 0)
          nums
          (begin
            (set! nums (append (take nums i) (list max-val) (drop nums (+ i 1))))
            (loop (- i 1) (max max-val (list-ref nums i))))))))