#lang racket

(define (prev-perm-with-one-swap nums)
  (define n (length nums))
  (define nums (list->vector nums))
  (define (swap i j)
    (let ((tmp (vector-ref nums i)))
      (vector-set! nums i (vector-ref nums j))
      (vector-set! nums j tmp)))
  (define (find-first-decreasing)
    (let loop ((i (- n 2)))
      (if (< i 0) -1
          (if (> (vector-ref nums i) (vector-ref nums (+ i 1)))
              i
              (loop (- i 1))))))
  (define (find-largest-smaller-than i)
    (let loop ((j (- n 1)))
      (if (>= j i) (if (< (vector-ref nums j) (vector-ref nums i)) j (loop (- j 1))) -1)))
  (let ((i (find-first-decreasing)))
    (if (= i -1) (reverse (vector->list nums))
        (let ((j (find-largest-smaller-than i)))
          (swap i j)
          (reverse (vector->list nums))))))