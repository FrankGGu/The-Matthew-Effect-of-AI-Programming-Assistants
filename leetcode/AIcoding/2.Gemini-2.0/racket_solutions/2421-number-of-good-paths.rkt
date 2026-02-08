(define (number-of-good-paths vals edges)
  (define n (vector-length vals))
  (define adj-list (make-vector n '()))
  (for-each (lambda (edge)
              (let ((u (vector-ref edge 0))
                    (v (vector-ref edge 1)))
                (vector-set! adj-list u (cons v (vector-ref adj-list u)))
                (vector-set! adj-list v (cons u (vector-ref adj-list v)))))
            edges)

  (define parent (make-vector n 0))
  (define size (make-vector n 1))

  (define (find u)
    (if (= u (vector-ref parent u))
        u
        (let ((root (find (vector-ref parent u))))
          (vector-set! parent u root)
          root)))

  (define (union u v)
    (let ((rootU (find u))
          (rootV (find v)))
      (if (= rootU rootV)
          #f
          (begin
            (if (< (vector-ref size rootU) (vector-ref size rootV))
                (begin
                  (vector-set! parent rootU rootV)
                  (vector-set! size rootV (+ (vector-ref size rootV) (vector-ref size rootU))))
                (begin
                  (vector-set! parent rootV rootU)
                  (vector-set! size rootU (+ (vector-ref size rootU) (vector-ref size rootV)))))
            #t))))

  (for ((i (in-range n))) (vector-set! parent i i))

  (define sorted-nodes (sort (range n) (lambda (a b) (< (vector-ref vals a) (vector-ref vals b)))))

  (define result 0)

  (for ((node (in-list sorted-nodes)))
    (define root (find node))
    (define count 1)
    (for ((neighbor (in-list (vector-ref adj-list node))))
      (if (<= (vector-ref vals neighbor) (vector-ref vals node))
          (let ((neighbor-root (find neighbor)))
            (if (!= root neighbor-root)
                (begin
                  (if (= (vector-ref vals neighbor) (vector-ref vals node))
                      (set! count (+ count (vector-ref size neighbor-root))))
                  (union node neighbor)))))
      )
    (set! result (+ result (vector-ref size root))))

  result)