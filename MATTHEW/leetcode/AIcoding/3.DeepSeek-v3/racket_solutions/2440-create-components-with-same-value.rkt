#lang racket

(define (component-value nums edges)
  (define n (length nums))
  (define adj (make-vector n '()))
  (for ([edge edges])
    (let ([u (first edge)]
          [v (second edge)])
      (vector-set! adj u (cons v (vector-ref adj u)))
      (vector-set! adj v (cons u (vector-ref adj v)))))

  (define total (apply + nums))
  (define max-k 0)

  (for ([k (in-range 1 (add1 total))])
    (when (zero? (remainder total k))
      (define target (/ total k))
      (define visited (make-vector n #f))
      (define possible #t)

      (define (dfs u)
        (vector-set! visited u #t)
        (define sum (list-ref nums u))
        (for ([v (vector-ref adj u)] #:when (not (vector-ref visited v)))
          (define sub-sum (dfs v))
          (if (>= sub-sum target)
              (set! possible (and possible (= sub-sum target)))
              (set! sum (+ sum sub-sum))))
        sum)

      (define root-sum (dfs 0))
      (when (and possible (= root-sum target))
        (set! max-k k))))

  max-k)