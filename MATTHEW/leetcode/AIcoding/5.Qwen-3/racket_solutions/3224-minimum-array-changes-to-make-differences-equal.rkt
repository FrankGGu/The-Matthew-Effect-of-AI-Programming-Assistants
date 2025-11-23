#lang racket

(define (min-array-changes nums)
  (define n (length nums))
  (define (get-diff i j)
    (abs (- (list-ref nums i) (list-ref nums j))))
  (define (check k)
    (let loop ((i 0) (j 1) (count 0))
      (cond
        [(>= i (- n 1)) #t]
        [(= j n) (loop (+ i 1) (+ i 2) count)]
        [else
         (if (= (get-diff i j) k)
             (loop i (+ j 1) count)
             (loop i (+ j 1) (+ count 1)))])))
  (let loop ((k 0))
    (if (check k) k (loop (+ k 1)))))