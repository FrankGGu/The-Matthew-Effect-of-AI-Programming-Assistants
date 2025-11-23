#lang racket

(define (magical-sequence-sum n)
  (define (product lst)
    (if (null? lst)
        1
        (* (car lst) (product (cdr lst)))))

  (define (generate-seq current length result)
    (if (= length n)
        (set! result (+ result (product current)))
        (for ([i (in-range 1 (add1 n))])
          (when (not (member i current))
            (generate-seq (append current (list i)) (+ length 1) result)))))

  (let ([result 0])
    (generate-seq '() 0 result)
    result))