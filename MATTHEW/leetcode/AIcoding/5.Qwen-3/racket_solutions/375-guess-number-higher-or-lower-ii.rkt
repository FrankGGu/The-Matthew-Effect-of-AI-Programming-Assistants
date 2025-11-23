#lang racket

(define (get-money_amount n)
  (define dp (make-vector (+ n 1) 0))
  (for ([i (in-range 2 (+ n 1))])
    (vector-set! dp i (* i 1000000))
    (for ([j (in-range 1 i)])
      (let ([cost (+ j (max (vector-ref dp j) (vector-ref dp (- i j 1))))])
        (when (< cost (vector-ref dp i))
          (vector-set! dp i cost)))))
  (vector-ref dp n))

(define (main)
  (let ([n (string->number (read-line))])
    (display (get-money_amount n))))

(main)