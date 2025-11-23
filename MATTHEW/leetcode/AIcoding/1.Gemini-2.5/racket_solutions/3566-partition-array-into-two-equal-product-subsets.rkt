#lang racket

(define (can-partition-array-into-two-equal-product-subsets nums)
  (let* ([n (length nums)]
         [num-zeros (for/fold ([count 0]) ([x nums])
                      (if (= x 0) (+ count 1) count))])

    (cond
      [(>= num-zeros 2) #t]
      [(= num-zeros 1) #f]
      [else
       (let ([total-log-abs-sum 0.0]
             [total-negative-count 0]
             [epsilon 1e-9])

         (for ([x nums])
           (set! total-log-abs-sum (+ total-log-abs-sum (log (abs (inexact x)))))
           (when (< x 0)
             (set! total-negative-count (+ total-negative-count 1))))

         (let loop ([i 0]
                    [current-nums nums]
                    [prefix-log-abs-sum 0.0]
                    [prefix-negative-count 0])

           (if (or (>= i (- n 1)) (null? current-nums))
               #f
               (let* ([current-num (car current-nums)]
                      [new-prefix-log-abs-sum (+ prefix-log-abs-sum (log (abs (inexact current-num))))]
                      [new-prefix-negative-count (if (< current-num 0) (+ prefix-negative-count 1) prefix-negative-count)]

                      [suffix-log-abs-sum (- total-log-abs-sum new-prefix-log-abs-sum)]
                      [suffix-negative-count (- total-negative-count new-prefix-negative-count)])

                 (if (and (< (abs (- new-prefix-log-abs-sum suffix-log-abs-sum)) epsilon)
                          (= (modulo new-prefix-negative-count 2) (modulo suffix-negative-count 2)))
                     #t
                     (loop (+ i 1) (cdr current-nums) new-prefix-log-abs-sum new-prefix-negative-count))))))])))