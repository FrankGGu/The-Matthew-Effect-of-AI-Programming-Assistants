#lang racket

(define (min-changes nums k)
  (let* ([n (length nums)]
         [freq (make-hash)]
         [dp (make-vector (bitwise-arithmetic-shift 1 10) +inf.0)]
         [new-dp (make-vector (bitwise-arithmetic-shift 1 10) +inf.0)])
    (vector-set! dp 0 0)
    (for ([i (in-range k)])
      (hash-clear! freq)
      (let ([count 0])
        (for ([j (in-range i n k)])
          (hash-update! freq (list-ref nums j) add1 0)
          (set! count (add1 count)))
      (let ([min-dp (apply min (vector->list dp))])
        (for ([xor (in-range (bitwise-arithmetic-shift 1 10))])
          (vector-set! new-dp xor min-dp))
      (for ([(num cnt) (in-hash freq)])
        (for ([xor (in-range (bitwise-arithmetic-shift 1 10))])
          (vector-set! new-dp (bitwise-xor xor num)
                       (min (vector-ref new-dp (bitwise-xor xor num))
                            (+ (vector-ref dp xor) (- count cnt))))))
      (set! dp (vector-copy new-dp)))
    (vector-ref dp 0)))