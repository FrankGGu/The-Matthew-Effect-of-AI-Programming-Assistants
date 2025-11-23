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

(define (prime-pairs-with-target-sum target)
  (let loop ([i 2] [result '()])
    (if (> i (quotient target 2))
        (reverse result)
        (if (and (is-prime i) (is-prime (- target i)))
            (loop (+ i 1) (cons (list i (- target i)) result))
            (loop (+ i 1) result)))))