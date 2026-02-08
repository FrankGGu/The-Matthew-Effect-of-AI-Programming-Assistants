(define (max-sum-of-weights n edges k)
  (define adj (make-vector n '()))
  (for-each (lambda (e)
              (let ([u (first e)] [v (second e)] [w (third e)])
                (vector-set! adj u (cons (cons v w) (vector-ref adj u)))
                (vector-set! adj v (cons (cons u w) (vector-ref adj v)))))
            edges)

  (define (calculate-sum removed)
    (define used-edges (make-hash))
    (for-each (lambda (e) (hash-set! used-edges e #t)) removed)

    (define total-weight 0)
    (for-each (lambda (e)
                (let ([u (first e)] [v (second e)] [w (third e)])
                  (unless (hash-has-key? used-edges (list u v w))
                    (set! total-weight (+ total-weight w)))))
              edges)
    total-weight)

  (define (all-combinations lst k)
    (cond
      [(zero? k) (list '())]
      [(empty? lst) '()]
      [else (append (map (lambda (comb) (cons (first lst) comb)) (all-combinations (rest lst) (- k 1)))
                    (all-combinations (rest lst) k))]))

  (let ([all-removed-combinations (all-combinations edges k)])
    (apply max (map calculate-sum all-removed-combinations))))