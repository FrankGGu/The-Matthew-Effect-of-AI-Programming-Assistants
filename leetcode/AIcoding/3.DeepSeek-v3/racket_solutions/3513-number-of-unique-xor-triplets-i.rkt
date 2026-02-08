#lang racket

(define (count-triplets nums)
  (let ([count 0]
        [n (length nums)])
    (for ([i (in-range n)])
      (for ([j (in-range i n)])
        (for ([k (in-range j n)])
          (let ([xor1 (bitwise-xor (list-ref nums i) (list-ref nums j))]
                [xor2 (bitwise-xor xor1 (list-ref nums k))])
            (when (zero? xor2)
              (set! count (add1 count))))))
    count))