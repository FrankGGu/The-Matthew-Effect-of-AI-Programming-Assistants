#lang racket

(define (count-triplets nums)
  (let ([n (length nums)]
        [count 0])
    (for* ([i (in-range n)]
           [j (in-range i n)]
           [k (in-range j n)])
      (when (zero? (bitwise-xor (list-ref nums i) (list-ref nums j) (list-ref nums k)))
        (set! count (add1 count))))
    count))