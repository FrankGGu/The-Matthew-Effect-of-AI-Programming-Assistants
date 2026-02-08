(define (checkMove board r c color)
  (define n (length board))
  (define m (length (car board)))
  (define (valid? x y)
    (and (>= x 0) (< x n) (>= y 0) (< y m)))

  (define (dfs x y)
    (when (valid? x y)
      (if (equal? (list-ref (list-ref board x) y) color)
          (begin
            (set! visited (cons (cons x y) visited))
            (for-each (lambda (d)
                        (dfs (+ x (car d)) (+ y (cdr d))))
                      '((1 0) (-1 0) (0 1) (0 -1)))))))

  (define visited '())
  (dfs r c)
  (define (all-visited?)
    (for/and ([x (in-range n)]
               [y (in-range m)])
      (or (not (equal? (list-ref (list-ref board x) y) color))
          (member (cons x y) visited))))
  (all-visited?))

(define (blackWhiteBoard board r c color)
  (if (checkMove board r c color)
      "Yes"
      "No"))