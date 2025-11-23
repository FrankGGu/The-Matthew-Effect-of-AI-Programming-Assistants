(define (num-similar-groups strs)
  (define n (length strs))
  (define parent (make-vector n 0))
  (define rank (make-vector n 0))

  (for ([i (in-range n)])
    (vector-set! parent i i)
    (vector-set! rank i 0))

  (define (find u)
    (if (equal? u (vector-ref parent u))
        u
        (let ([pu (find (vector-ref parent u))])
          (vector-set! parent u pu)
          pu)))

  (define (union u v)
    (let ([pu (find u)]
          [pv (find v)])
      (unless (equal? pu pv)
        (if (> (vector-ref rank pu) (vector-ref rank pv))
            (vector-set! parent pv pu)
            (begin
              (vector-set! parent pu pv)
              (when (equal? (vector-ref rank pu) (vector-ref rank pv))
                (vector-set! rank pv (+ (vector-ref rank pv) 1)))))))))
    #f)

  (define (similar? a b)
    (let loop ([diff 0] [i 0])
      (if (>= i (string-length a))
          (or (zero? diff) (= diff 2))
          (if (equal? (string-ref a i) (string-ref b i))
              (loop diff (+ i 1))
              (if (>= diff 2)
                  #f
                  (loop (+ diff 1) (+ i 1)))))))

  (for ([i (in-range n)])
    (for ([j (in-range (+ i 1) n)])
      (when (similar? (list-ref strs i) (list-ref strs j))
        (union i j))))

  (let loop ([i 0] [count 0])
    (if (>= i n)
        count
        (if (equal? i (vector-ref parent i))
            (loop (+ i 1) (+ count 1))
            (loop (+ i 1) count)))))