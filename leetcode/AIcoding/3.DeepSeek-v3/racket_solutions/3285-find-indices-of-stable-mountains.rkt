#lang racket

(define (find-stable-mountains mountains)
  (define n (length mountains))
  (define result '())
  (define (peak? i)
    (and (> i 0) (< i (- n 1))
         (> (list-ref mountains i) (list-ref mountains (- i 1)))
         (> (list-ref mountains i) (list-ref mountains (+ i 1)))))
  (define (left-base i)
    (let loop ((j (- i 1)))
      (cond
        [(< j 0) 0]
        [(<= (list-ref mountains j) (list-ref mountains (+ j 1))) j]
        [else (loop (- j 1))])))
  (define (right-base i)
    (let loop ((j (+ i 1)))
      (cond
        [(>= j n) (- n 1)]
        [(<= (list-ref mountains j) (list-ref mountains (- j 1))) j]
        [else (loop (+ j 1))])))
  (for ([i (in-range n)])
    (when (peak? i)
      (let ([l (left-base i)]
            [r (right-base i)])
        (when (and (>= (- i l) 2) (>= (- r i) 2))
          (set! result (cons (list l r) result))))))
  (reverse result))