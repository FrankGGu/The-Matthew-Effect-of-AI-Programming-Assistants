#lang racket

(define (is-monotonic nums)
  (define len (length nums))
  (if (<= len 2)
      #t
      (let loop ((i 0) (inc #t) (dec #t))
        (cond ((= i (- len 1)) #t)
              ((and inc dec) (loop (+ i 1) #t #t))
              ((and (not inc) (not dec)) #f)
              ((and inc (<= (list-ref nums i) (list-ref nums (+ i 1)))) (loop (+ i 1) #t dec))
              ((and dec (>= (list-ref nums i) (list-ref nums (+ i 1)))) (loop (+ i 1) inc #t))
              (else #f)))))