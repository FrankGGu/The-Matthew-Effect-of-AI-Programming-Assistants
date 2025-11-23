(define (cycleLengthQueries n queries)
  (define (find-parent x)
    (if (= x 0)
        0
        (let loop ((x x))
          (if (= x 0)
              0
              (loop (quotient (- x 1) 2))))))

  (define (lca a b)
    (if (= a b)
        a
        (let loop ((a a) (b b))
          (if (= a b)
              a
              (loop (find-parent a) (find-parent b))))))

  (define (cycle-length a b)
    (define lca-node (lca a b))
    (+ (count-path a lca-node)
       (count-path b lca-node)))

  (define (count-path x target)
    (if (= x target)
        0
        (+ 1 (count-path (find-parent x) target))))

  (map (lambda (query)
         (cycle-length (car query) (cadr query)))
       queries))