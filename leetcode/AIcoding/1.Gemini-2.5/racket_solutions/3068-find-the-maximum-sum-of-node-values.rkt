#lang racket

(define (maximum-value-sum nums k edges)
  (let* ([initial-sum (apply + nums)]
         [n (length nums)])
    (let-values ([(total-gain num-positive-gains min-abs-gain)
                  (for/fold ([current-total-gain 0]
                             [current-num-positive-gains 0]
                             [current-min-abs-gain (expt 2 60)]) ; Initialize with a sufficiently large number
                            ([val nums])
                    (let* ([val-xor-k (bitwise-xor val k)]
                           [gain (- val-xor-k val)])
                      (values
                       (if (> gain 0) (+ current-total-gain gain) current-total-gain)
                       (if (> gain 0) (+ current-num-positive-gains 1) current-num-positive-gains)
                       (min current-min-abs-gain (abs gain)))))]
                 )
      (let ([final-sum (+ initial-sum total-gain)])
        (if (even? num-positive-gains)
            final-sum
            (- final-sum min-abs-gain))))))