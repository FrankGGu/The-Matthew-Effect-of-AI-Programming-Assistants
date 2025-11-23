(define/contract (combination-sum3 k n)
  (-> exact-integer? exact-integer? (listof (listof exact-integer?)))
  (define (backtrack start target path res)
    (cond
      [(and (zero? target) (= (length path) k)) (cons (reverse path) res)]
      [(or (<= target 0) (> (length path) k)) res]
      [else
       (for/fold ([res res])
                 ([i (in-range start 10)])
         (backtrack (+ i 1) (- target i) (cons i path) res))]))
  (backtrack 1 n '() '()))