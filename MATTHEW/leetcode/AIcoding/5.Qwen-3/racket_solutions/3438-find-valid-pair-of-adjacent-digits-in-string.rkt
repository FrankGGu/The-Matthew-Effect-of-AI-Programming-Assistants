#lang racket

(define (valid-pair s)
  (define len (string-length s))
  (for/first ([i (in-range (sub1 len))])
    (if (= (string-ref s i) (string-ref s (add1 i)))
        #t
        #f))
  #f)

(define (main)
  (define input (read-line))
  (define result (valid-pair input))
  (printf "~a\n" (if result "true" "false")))

(main)