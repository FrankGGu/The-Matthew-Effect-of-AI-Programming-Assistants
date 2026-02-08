#lang racket

(define (min-subarray-len-divisible-by-p nums p)
  (define n (length nums))

  (define total-sum (for/sum ([x nums]) x))
  (define target-remainder (modulo total-sum p))

  (when (= target-remainder 0)
    (if (empty? nums)
        0
        0))

  (define min-len n)
  (define current-prefix-remainder 0)
  (define remainder-to-index (hash 0 -1))

  (for ([i (in-range n)]
        [num nums])
    (set! current-prefix-remainder (modulo (+ current-prefix-remainder num) p))

    (define required-prev-remainder (modulo (- current-prefix-remainder target-remainder) p))

    (when (hash-has-key? remainder-to-index required-prev-remainder)
      (define prev-index (hash-ref remainder-to-index required-prev-remainder))
      (set! min-len (min min-len (- i prev-index))))

    (hash-set! remainder-to-index current-prefix-remainder i))

  (if (= min-len n)
      -1
      min-len))