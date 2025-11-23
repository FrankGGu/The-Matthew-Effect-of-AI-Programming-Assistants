#lang racket

(define (game guess answer)
  (let loop ((i 0) (count 0))
    (if (= i (vector-length guess))
        count
        (loop (+ i 1) 
              (if (= (vector-ref guess i) (vector-ref answer i))
                  (+ count 1)
                  count)))))