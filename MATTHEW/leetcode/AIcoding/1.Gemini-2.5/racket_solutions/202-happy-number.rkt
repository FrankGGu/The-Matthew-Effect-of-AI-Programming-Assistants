#lang racket

(define (sum-of-squares-of-digits n)
  (let loop ((num n) (sum 0))
    (if (zero? num)
        sum
        (let* ((digit (modulo num 10))
               (new-sum (+ sum (* digit digit))))
          (loop (quotient num 10) new-sum)))))

(define (is-happy n)
  (let loop ((current-n n) (seen (set)))
    (cond
      ((= current-n 1) #t)
      ((set-member? seen current-n) #f)
      (else
       (loop (sum-of-squares-of-digits current-n)
             (set-add seen current-n))))))