(define (are-connected n threshold a b)
  (define (find uf x)
    (if (= x (vector-ref uf x))
        x
        (let ((root (find uf (vector-ref uf x))))
          (vector-set! uf x root)
          root)))

  (define (union uf x y)
    (let ((root_x (find uf x))
          (root_y (find uf y)))
      (if (!= root_x root_y)
          (vector-set! uf root_x root_y))))

  (define uf (for/vector ([i (in-range (+ 1 n))]) i))

  (for ([i (in-range 1 (+ 1 n))])
    (for ([j (in-range (+ 1 i (+ 1 n)))])
      (if (> (gcd i j) threshold)
          (union uf i j))))

  (= (find uf a) (find uf b)))

(define (graph-connectivity-with-threshold n threshold queries)
  (map (lambda (q) (are-connected n threshold (car q) (cadr q))) queries))