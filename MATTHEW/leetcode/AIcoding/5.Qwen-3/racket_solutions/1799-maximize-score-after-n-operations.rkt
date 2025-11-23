#lang racket

(define (maximize-score nums)
  (define n (length nums))
  (define memo (make-hash))

  (define (gcd a b)
    (if (= b 0)
        a
        (gcd b (remainder a b))))

  (define (dfs used mask)
    (cond
      [(hash-has-key? memo mask) (hash-ref memo mask)]
      [else
       (define count (bit-count mask))
       (if (= count n)
           0
           (let loop ([i 0] [res -inf.0])
             (if (= i n)
                 (begin
                   (hash-set! memo mask res)
                   res)
                 (if (bitwise-bit-set? mask i)
                     (loop (+ i 1) res)
                     (let ([next-mask (bitwise-ior mask (arithmetic-shift 1 i))])
                       (loop (+ i 1) (max res (+ (gcd (list-ref nums i) (list-ref nums j)) (dfs next-mask)))))))))
       ]))

  (dfs 0 0))