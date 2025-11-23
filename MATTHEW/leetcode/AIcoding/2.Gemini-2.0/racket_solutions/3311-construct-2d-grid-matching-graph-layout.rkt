(define (find-all-paths n m edges)
  (define adj (make-hash))
  (for ([edge edges])
    (define u (car edge))
    (define v (cadr edge))
    (hash-update! adj u (lambda (x) (cons v x)) '()))

  (define (valid-coords? row col)
    (and (>= row 0) (< row n) (>= col 0) (< col m)))

  (define (node-to-coords node)
    (list (quotient node m) (remainder node m)))

  (define (coords-to-node row col)
    (+ (* row m) col))

  (define (neighbors node)
    (cond
      [(hash-has-key? adj node) (hash-ref adj node)]
      [else '()]))

  (define (solve)
    (let loop ([path '()] [visited (make-hash)])
      (if (= (length path) (* n m))
          (list path)
          (let ([current-node (if (empty? path) 0 (car path))])
            (foldl (lambda (neighbor acc)
                     (if (not (hash-has-key? visited neighbor))
                         (begin
                           (hash-set! visited neighbor #t)
                           (append acc (loop (cons neighbor path) visited))
                           (hash-remove! visited neighbor))
                         acc))
                   '()
                   (neighbors current-node))))))

  (let ([paths (solve)])
    (if (empty? paths)
        #f
        (let ([path (car paths)])
          (reverse path)))))

(define (construct-2d-grid n m edges)
  (let ([path (find-all-paths n m edges)])
    (if path
        (map (lambda (node) (list (quotient node m) (remainder node m))) path)
        '())))