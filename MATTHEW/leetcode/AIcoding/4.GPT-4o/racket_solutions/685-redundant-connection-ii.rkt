(define (findRedundantDirectedConnection edges)
  (define (find-parent parent x)
    (if (not (equal? (vector-ref parent x) x))
        (find-parent parent (vector-ref parent x))
        x))

  (define (union parent rank x y)
    (let ((rootX (find-parent parent x))
          (rootY (find-parent parent y)))
      (if (not (equal? rootX rootY))
          (begin
            (if (< (vector-ref rank rootX) (vector-ref rank rootY))
                (begin
                  (vector-set! parent rootX rootY)
                  (vector-set! rank rootY (+ (vector-ref rank rootY) (vector-ref rank rootX))))
                (begin
                  (vector-set! parent rootY rootX)
                  (vector-set! rank rootX (+ (vector-ref rank rootX) (vector-ref rank rootY)))))))))

  (define (detect-cycle parent edges)
    (for/fold ([found #f]) ([edge edges])
      (let* ([u (sub1 (car edge))]
             [v (sub1 (cadr edge))]
             [rootU (find-parent parent u)]
             [rootV (find-parent parent v)])
        (if (equal? rootU rootV)
            #t
            (begin
              (union parent (make-vector (add1 (length edges)) 0) u v)
              found)))))

  (define parent (make-vector (+ 1 (length edges)) 0))
  (define rank (make-vector (+ 1 (length edges)) 0))
  (define conflict #f)

  (for ([edge edges])
    (let* ([u (sub1 (car edge))]
           [v (sub1 (cadr edge))])
      (if (not (equal? (vector-ref parent v) 0))
          (set! conflict edge)
          (vector-set! parent v u))))

  (if (detect-cycle parent edges)
      (if conflict
          (begin
            (vector-set! parent (sub1 (car conflict)) (sub1 (cadr conflict)))
            (if (detect-cycle parent edges)
                conflict
                (vector (car conflict) (cadr conflict))))
          (vector (car (last edges)) (cadr (last edges))))
      (vector (car (last edges)) (cadr (last edges)))))