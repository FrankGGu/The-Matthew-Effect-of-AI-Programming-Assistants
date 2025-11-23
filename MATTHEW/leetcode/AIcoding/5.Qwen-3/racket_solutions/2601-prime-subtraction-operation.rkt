#lang racket

(define (is-prime n)
  (cond [(<= n 1) #f]
        [(= n 2) #t]
        [(even? n) #f]
        [else
         (let loop ([i 3])
           (if (> i (sqrt n))
               #t
               (if (= (modulo n i) 0)
                   #f
                   (loop (+ i 2)))))]))

(define (prime-subtraction-operation nums)
  (define (find-min-prime x)
    (let loop ([p 2])
      (if (and (<= p x) (is-prime p))
          (if (<= (- x p) 0)
              #f
              p)
          #f)))

  (let loop ([nums nums] [res '()])
    (if (null? nums)
        res
        (let* ([x (car nums)]
               [p (find-min-prime x)])
          (if p
              (loop (cdr nums) (cons (- x p) res))
              #f)))))