#lang racket/base

(define (duplicate-zeros arr)
  (define n (vector-length arr))
  (when (> n 0)
    (define zeros 0)
    (define i 0)

    (let loop ((current-i 0) (current-zeros 0))
      (if (and (< current-i n) (< (+ current-i current-zeros) n))
          (if (= (vector-ref arr current-i) 0)
              (loop (+ current-i 1) (+ current-zeros 1))
              (loop (+ current-i 1) current-zeros))
          (begin
            (set! i current-i)
            (set! zeros current-zeros))))

    (define j (- n 1))
    (set! i (- i 1))

    (when (and (= (+ i zeros) n) (= (vector-ref arr i) 0))
      (vector-set! arr j 0)
      (set! j (- j 1))
      (set! i (- i 1)))

    (let loop-fill ((read-idx i) (write-idx j))
      (when (>= read-idx 0)
        (if (= (vector-ref arr read-idx) 0)
            (begin
              (vector-set! arr write-idx 0)
              (vector-set! arr (- write-idx 1) 0)
              (loop-fill (- read-idx 1) (- write-idx 2)))
            (begin
              (vector-set! arr write-idx (vector-ref arr read-idx))
              (loop-fill (- read-idx 1) (- write-idx 1)))))))
  arr)