#lang racket

(define mountain-get
  (lambda (index)
    (vector-ref mountain-array index)))

(define (find-in-mountain-array target mountain-array)
  (let ([n (vector-length mountain-array)])
    (let ([peak (find-peak mountain-array 0 (- n 1))])
      (let ([left-result (binary-search mountain-array 0 peak target #t)])
        (if (not (= left-result -1))
            left-result
            (binary-search mountain-array (+ peak 1) (- n 1) target #f))))))

(define (find-peak arr left right)
  (while (< left right)
    (let ([mid (quotient (+ left right) 2)])
      (if (> (mountain-get mid) (mountain-get (+ mid 1)))
          (set! right mid)
          (set! left (+ mid 1)))))
  left)

(define (binary-search arr left right target is-ascending)
  (while (<= left right)
    (let ([mid (quotient (+ left right) 2)])
      (let ([mid-val (mountain-get mid)])
        (cond
          [(= mid-val target) mid]
          [(if is-ascending
               (< mid-val target)
               (> mid-val target))
           (set! left (+ mid 1))]
          [else
           (set! right (- mid 1))]))))
  -1)