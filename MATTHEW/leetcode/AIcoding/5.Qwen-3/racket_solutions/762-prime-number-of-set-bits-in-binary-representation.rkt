#lang racket

(define (is-prime n)
  (cond [(<= n 1) #f]
        [(= n 2) #t]
        [(even? n) #f]
        [else
         (define (check i)
           (if (> i (sqrt n))
               #t
               (if (= (remainder n i) 0)
                   #f
                   (check (+ i 2)))))
         (check 3)]))

(define (count-set-bits n)
  (define (helper m count)
    (if (= m 0)
        count
        (helper (quotient m 2) (+ count (remainder m 2)))))
  (helper n 0))

(define (num-primed-bits left right)
  (define (iter current result)
    (if (> current right)
        result
        (iter (+ current 1) (+ result (if (is-prime (count-set-bits current)) 1 0)))))
  (iter left 0))