(define (maximum-genetic-difference queries)
  (define (find-parent parent x)
    (if (not (= (vector-ref parent x) x))
        (find-parent parent (vector-ref parent x))
        x))

  (define (union parent rank x y)
    (define root-x (find-parent parent x))
    (define root-y (find-parent parent y))
    (if (not (= root-x root-y))
        (begin
          (if (< (vector-ref rank root-x) (vector-ref rank root-y))
              (begin
                (vector-set! parent root-x root-y))
              (begin
                (vector-set! parent root-y root-x)
                (when (= (vector-ref rank root-x) (vector-ref rank root-y))
                  (vector-set! rank root-x (+ (vector-ref rank root-x) 1))))))))

  (define n (length queries))
  (define parent (make-vector n))
  (define rank (make-vector n 0))

  (for ((i (in-range n)))
    (vector-set! parent i i))

  (for ((query queries))
    (define a (car query))
    (define b (cadr query))
    (union parent rank a b))

  (define result '())
  (for ((query queries))
    (define a (car query))
    (define b (cadr query))
    (define res (bitwise-xor a b))
    (set! result (cons res result)))

  (reverse result))

(maximum-genetic-difference '((1 2) (3 4) (5 6) (7 8)))