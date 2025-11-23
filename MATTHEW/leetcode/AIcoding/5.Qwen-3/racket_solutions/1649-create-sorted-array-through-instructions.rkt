#lang racket

(define (create-sorted-array instructions)
  (define (count-less-or-equal lst x)
    (for/sum ([n lst])
      (if (<= n x) 1 0)))

  (define (count-greater-or-equal lst x)
    (for/sum ([n lst])
      (if (>= n x) 1 0)))

  (define (solve instructions)
    (let loop ([inst instructions] [arr '()] [res 0])
      (if (null? inst)
          res
          (let* ([x (car inst)]
                 [less (count-less-or-equal arr x)]
                 [greater (count-greater-or-equal arr x)])
            (loop (cdr inst) (cons x arr) (+ res (min less greater)))))))

  (solve instructions))