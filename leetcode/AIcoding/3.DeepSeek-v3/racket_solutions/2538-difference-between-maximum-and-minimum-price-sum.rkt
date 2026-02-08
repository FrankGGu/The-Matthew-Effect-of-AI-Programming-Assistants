#lang racket

(define (max-price-sum-difference prices edges)
  (define n (length prices))
  (define adj (make-vector n '()))
  (for ([edge edges])
    (let ([u (first edge)]
          [v (second edge)])
      (vector-set! adj u (cons v (vector-ref adj u)))
      (vector-set! adj v (cons u (vector-ref adj v)))))

  (define max-sum 0)
  (define min-sum +inf.0)

  (define (dfs u parent)
    (let ([current (list-ref prices u)])
      (define child-sums '())
      (for ([v (vector-ref adj u)])
        (unless (equal? v parent)
          (set! child-sums (cons (dfs v u) child-sums))))
      (if (null? child-sums)
          current
          (let ([max-child (apply max child-sums)]
                [min-child (apply min child-sums)])
            (set! max-sum (max max-sum (+ current max-child)))
            (set! min-sum (min min-sum (+ current min-child)))
            (+ current max-child))))

  (dfs 0 -1)
  (- max-sum min-sum))