#lang racket

(define (is-square? s)
  (define n (string->number s))
  (define sqrt-n (sqrt n))
  (and (integer? sqrt-n) (= (* sqrt-n sqrt-n) n)))

(define (check s)
  (cond [(= (string-length s) 0) #t]
        [else
         (let loop ([i 1])
           (if (> i (string-length s))
               #f
               (let ([sub (substring s 0 i)])
                 (if (is-square? sub)
                     (or (check (substring s i))
                         (loop (+ i 1)))
                     (loop (+ i 1))))))]))

(define (punishment-number n)
  (define (helper i)
    (if (> i n)
        0
        (if (check (number->string i))
            (+ i (helper (+ i 1)))
            (helper (+ i 1)))))
  (helper 1))

(define (main)
  (define input (read-line))
  (define n (string->number input))
  (display (punishment-number n)))

(main)