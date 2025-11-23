#lang racket

(define (kth-smallest matrix k)
  (define (count-less-equal x)
    (define (count-in-row row)
      (length (filter (lambda (y) (<= y x)) row)))
    (apply + (map count-in-row matrix)))

  (define (binary-search low high)
    (if (< low high)
        (let* ((mid (quotient (+ low high) 2))
               (count (count-less-equal mid)))
          (if (< count k)
              (binary-search (+ mid 1) high)
              (binary-search low mid)))
        low))

  (define min-val (car (append (map car matrix) '())))
  (define max-val (car (reverse (append (map (lambda (row) (car (reverse row))) matrix) '()))))
  (binary-search min-val (+ max-val 1)))

(kth-smallest '((1 5 9) (10 11 13) (12 13 15)) 8)