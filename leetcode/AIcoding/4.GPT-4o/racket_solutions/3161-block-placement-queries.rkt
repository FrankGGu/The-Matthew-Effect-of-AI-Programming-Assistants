(define (can-place-blocks blocks queries)
  (define (placeable? grid x y l h)
    (for/fold ([result #t]) ([i x (+ x l)])
      (if (or (not result) (> (vector-ref grid i) h))
          result
          (for/fold ([res result]) ([j y (+ y h)])
            (if (or (> (vector-ref grid i) h) (< j y))
                res
                #f))))
  (define grid (make-vector (length blocks) 0))
  (for ([i (in-range (length blocks))])
    (vector-set! grid i (vector-ref blocks i)))
  (map (lambda (q)
         (let ([x (car q)]
               [y (cadr q)]
               [l (caddr q)]
               [h (cadddr q)])
           (placeable? grid x y l h)))
       queries))

(define (blockPlacementQueries blocks queries)
  (can-place-blocks blocks queries))