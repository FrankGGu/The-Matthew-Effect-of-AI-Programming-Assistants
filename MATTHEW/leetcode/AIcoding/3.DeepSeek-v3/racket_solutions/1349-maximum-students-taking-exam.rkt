#lang racket

(define (max-students seats)
  (define m (length seats))
  (define n (if (null? seats) 0 (length (car seats))))
  (define dp (make-hash))

  (define (get-mask row)
    (for/fold ([mask 0] [bit 1] #:result mask)
              ([c (in-list (list-ref seats row))] [j (in-range n)])
      (values (if (char=? c #\.) (bitwise-ior mask bit) mask) (arithmetic-shift bit 1))))

  (define (valid? mask)
    (not (bitwise-bit-set? (bitwise-and mask (arithmetic-shift mask 1)) 0)))

  (define (count-bits mask)
    (for/sum ([i (in-range n)])
      (if (bitwise-bit-set? mask i) 1 0)))

  (define (solve row prev-mask)
    (if (>= row m)
        0
        (let ([key (cons row prev-mask)])
          (if (hash-has-key? dp key)
              (hash-ref dp key)
              (let* ([current-mask (get-mask row)]
                     [max-count 0])
                (for ([mask (in-range (arithmetic-shift 1 n))])
                  (when (and (zero? (bitwise-and mask (bitwise-not current-mask)))
                             (valid? mask)
                             (valid? (bitwise-or mask (arithmetic-shift prev-mask 1)))
                             (valid? (bitwise-or (arithmetic-shift mask 1) prev-mask)))
                    (set! max-count (max max-count (+ (count-bits mask) (solve (add1 row) mask))))))
                (hash-set! dp key max-count)
                max-count)))))

  (solve 0 0))