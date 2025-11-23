#lang racket

(define range-freq-query%
  (class object%
    (super-new)
    (init-field arr)
    (define hash (make-hash))
    (for ([(val idx) (in-indexed arr)])
      (hash-update! hash val (lambda (lst) (cons idx lst)) '()))

    (define/public (query left right value)
      (define lst (reverse (hash-ref hash value '())))
      (define l (bisect-left lst left))
      (define r (bisect-right lst right))
      (- r l))

    (define (bisect-left lst target)
      (let loop ([low 0]
                 [high (length lst)])
        (if (< low high)
            (let* ([mid (quotient (+ low high) 2)]
                   [mid-val (list-ref lst mid)])
              (if (< mid-val target)
                  (loop (add1 mid) high)
                  (loop low mid)))
            low)))

    (define (bisect-right lst target)
      (let loop ([low 0]
                 [high (length lst)])
        (if (< low high)
            (let* ([mid (quotient (+ low high) 2)]
                   [mid-val (list-ref lst mid)])
              (if (<= mid-val target)
                  (loop (add1 mid) high)
                  (loop low mid)))
            high))))
)

(define (make-range-freq-query arr)
  (new range-freq-query% [arr arr]))

(define (range-freq-query-query obj left right value)
  (send obj query left right value))