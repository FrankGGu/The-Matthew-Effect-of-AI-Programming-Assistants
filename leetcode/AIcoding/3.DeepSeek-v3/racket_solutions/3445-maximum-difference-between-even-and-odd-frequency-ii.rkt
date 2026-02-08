#lang racket

(define (max-difference nums)
  (let* ([freq (make-hash)]
         [even-sum 0]
         [odd-sum 0])
    (for ([num nums])
      (hash-update! freq num add1 (lambda () 0)))
    (for ([(k v) freq])
      (if (even? v)
          (set! even-sum (+ even-sum v))
          (set! odd-sum (+ odd-sum v))))
    (abs (- even-sum odd-sum))))