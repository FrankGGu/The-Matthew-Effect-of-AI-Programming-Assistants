#lang racket

(define (maximum-good statements)
  (define n (length statements))
  (define max-good 0)

  (define (valid? mask)
    (for/and ([i (in-range n)])
      (if (bitwise-bit-set? mask i)
          (for/and ([j (in-range n)])
            (let ([claim (list-ref (list-ref statements i) j)])
            (or (= claim 2)
                (eq? (= claim 1) (bitwise-bit-set? mask j))))
          #t)))

  (for ([mask (in-range (expt 2 n))])
    (when (valid? mask)
      (set! max-good (max max-good (bitwise-bit-count mask)))))

  max-good)