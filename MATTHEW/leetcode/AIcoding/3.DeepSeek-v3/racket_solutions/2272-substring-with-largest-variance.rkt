#lang racket

(define (largestVariance s)
  (define n (string-length s))
  (define max-var 0)
  (define chars (remove-duplicates (string->list s)))

  (for* ([a chars] [b chars] #:unless (equal? a b))
    (define cnt-a 0)
    (define cnt-b 0)
    (define has-b #f)
    (define first-b #f)

    (for ([c (in-string s)])
      (cond
        [(equal? c a) (set! cnt-a (add1 cnt-a))]
        [(equal? c b) (set! cnt-b (add1 cnt-b))])

      (when (positive? cnt-b)
        (set! max-var (max max-var (- cnt-a cnt-b)))
      (when (and (< cnt-a cnt-b) (positive? cnt-b))
        (set! cnt-a 0)
        (set! cnt-b 0)
        (set! first-b #t))

      (when (and first-b (zero? cnt-b))
        (set! first-b #f)
        (set! cnt-b 1))))

  max-var)