(define (longest-path parent s)
  (let* ([n (length parent)]
         [children (make-vector n '())]
         [result 0])
    (for ([i (in-range 1 n)])
      (vector-set! children (list-ref parent i) (cons i (vector-ref children (list-ref parent i))))
    (define (dfs node)
      (let ([max1 0]
            [max2 0])
        (for ([child (vector-ref children node)])
          (let ([child-path (dfs child)])
            (when (not (eq? (string-ref s node) (string-ref s child)))
              (if (> child-path max1)
                  (begin
                    (set! max2 max1)
                    (set! max1 child-path))
                  (when (> child-path max2)
                    (set! max2 child-path))))))
        (set! result (max result (+ max1 max2 1)))
        (+ max1 1)))
    (dfs 0)
    result))