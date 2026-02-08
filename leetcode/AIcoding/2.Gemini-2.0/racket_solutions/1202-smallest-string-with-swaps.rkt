(define (smallest-string-with-swaps s pairs)
  (define n (string-length s))
  (define parent (make-vector n))
  (for ([i (in-range n)])
    (vector-set! parent i i))

  (define (find x)
    (if (= (vector-ref parent x) x)
        x
        (let ([root (find (vector-ref parent x))])
          (vector-set! parent x root)
          root)))

  (define (union x y)
    (let ([root-x (find x)]
          [root-y (find y)])
      (if (!= root-x root-y)
          (vector-set! parent root-x root-y))))

  (for ([pair (in-list pairs)])
    (union (car pair) (cadr pair)))

  (define components (make-hash))
  (for ([i (in-range n)])
    (let ([root (find i)])
      (hash-update components root (lambda (xs) (cons i xs)) '())))

  (define result (string-copy s))
  (for ([(root indices) (in-hash components)])
    (let* ([chars (sort (map (lambda (i) (string-ref s i)) indices) char<?)]
           [sorted-indices (sort indices <)])
      (for ([i (in-range (length indices))])
        (string-set! result (list-ref sorted-indices i) (list-ref chars i)))))

  result)