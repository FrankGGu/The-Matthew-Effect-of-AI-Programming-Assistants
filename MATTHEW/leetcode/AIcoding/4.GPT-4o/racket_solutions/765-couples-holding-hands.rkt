(define (min-swaps couples)
  (define n (length couples))
  (define pairs (map (lambda (x) (list (car x) (cadr x))) couples))
  (define positions (make-vector n))
  (for ([i (in-range n)])
    (vector-set! positions (car (list-ref pairs i)) i))
  (define visited (make-vector n #f))
  (define swaps 0)

  (define (dfs i)
    (if (vector-ref visited i)
        0
        (begin
          (vector-set! visited i #t)
          (define partner (vector-ref positions i))
          (if (equal? partner i)
              (dfs (cdr (list-ref pairs i)))
              (begin
                (set! swaps (+ swaps 1))
                (dfs partner))))))

  (for ([i (in-range n)])
    (when (not (vector-ref visited i))
      (dfs i)))

  swaps)

(min-swaps '((0 1) (2 3) (4 5) (6 7)))