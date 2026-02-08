(define (make-smallest-array nums swaps)
  (define (find-parent parent x)
    (if (equal? (vector-ref parent x) x)
        x
        (find-parent parent (vector-ref parent x))))

  (define (union parent x y)
    (define rootX (find-parent parent x))
    (define rootY (find-parent parent y))
    (when (not (equal? rootX rootY))
      (vector-set! parent rootX rootY)))

  (define n (vector-length nums))
  (define parent (make-vector n))
  (for ([i (in-range n)])
    (vector-set! parent i i))

  (for ([swaps swaps])
    (union parent (car swaps) (cadr swaps)))

  (define components (make-hash))
  (for ([i (in-range n)])
    (define root (find-parent parent i))
    (hash-set! components root (cons i (hash-ref components root '()))))

  (define result (vector-copy nums))
  (for-each (lambda (indices)
              (define sorted (sort (map (lambda (i) (vector-ref nums i)) indices) <))
              (for ([i (in-range (length indices))])
                (vector-set! result (list-ref indices i) (list-ref sorted i))))
            (hash-values components))

  (vector->list result))

(define (makeLexSmallestArray nums swaps)
  (make-smallest-array (vector->list nums) swaps))