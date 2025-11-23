#lang racket

(define (max-fruits basket k)
  (define (helper left right count)
    (if (> right (sub1 (vector-length basket)))
        (if (>= (vector-ref basket left) 2)
            (add1 (helper (add1 left) left count))
            count)
        (let ([current (vector-ref basket right)])
          (if (and (>= current 2) (not (= current (vector-ref basket left))))
              (helper (add1 left) right (add1 count))
              (helper left (add1 right) count)))))
  (helper 0 0 0))

(define (main)
  (define input (read-line))
  (define k (string->number (car (string-split input))))
  (define basket (vector-map string->number (map (lambda (s) (string-trim s)) (string-split (read-line) " "))))
  (display (max-fruits basket k)))

(main)