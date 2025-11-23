(define (max-min-price-sum n prices edges)
  (define adj (make-vector n '()))
  (for-each (lambda (edge)
              (define u (car edge))
              (define v (cadr edge))
              (vector-set! adj u (cons v (vector-ref adj u)))
              (vector-set! adj v (cons u (vector-ref adj v))))
            edges)

  (define overall-max-path-sum (- inf.0))
  (define overall-min-path-sum (+ inf.0))

  (define (dfs u p)
    (define current-price (list-ref prices u))

    (define max-branch-sum current-price)
    (define min-branch-sum current-price)

    (set! overall-max-path-sum (max overall-max-path-sum current-price))
    (set! overall-min-path-sum (min overall-min-path-sum current-price))

    (for-each (lambda (v)
                (when (not (= v p))
                  (define child-sums (dfs v u))
                  (define child-max-branch-sum (car child-sums))
                  (define child-min-branch-sum (cdr child-sums))

                  (set! overall-max-path-sum (max overall-max-path-sum
                                                  (+ max-branch-sum child-max-branch-sum (- current-price))))
                  (set! overall-min-path-sum (min overall-min-path-sum
                                                  (+ min-branch-sum child-min-branch-sum (- current-price))))

                  (set! max-branch-sum (max max-branch-sum (+ current-price child-max-branch-sum)))
                  (set! min-branch-sum (min min-branch-sum (+ current-price child-min-branch-sum)))
                  ))
              (vector-ref adj u))

    (set! overall-max-path-sum (max overall-max-path-sum max-branch-sum))
    (set! overall-min-path-sum (min overall-min-path-sum min-branch-sum))

    (cons max-branch-sum min-branch-sum))

  (dfs 0 -1)

  (- overall-max-path-sum overall-min-path-sum))