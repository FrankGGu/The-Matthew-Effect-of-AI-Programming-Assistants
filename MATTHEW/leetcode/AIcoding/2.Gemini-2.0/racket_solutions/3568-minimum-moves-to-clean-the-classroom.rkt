(define (minimum-moves classroom)
  (define n (vector-length classroom))
  (define m (vector-length (vector-ref classroom 0)))

  (define (is-valid? r c)
    (and (>= r 0) (< r n) (>= c 0) (< c m)))

  (define (dirty-cells classroom)
    (for*/list ([r (in-range n)]
                [c (in-range m)]
                #:when (equal? (vector-ref (vector-ref classroom r) c) 1))
      (cons r c)))

  (define (manhattan-distance r1 c1 r2 c2)
    (+ (abs (- r1 r2)) (abs (- c1 c2))))

  (define (solve current-classroom current-moves)
    (let ([dirty (dirty-cells current-classroom)])
      (if (null? dirty)
          current-moves
          (let ([best-moves #f])
            (for* ([start-r (in-range n)]
                   [start-c (in-range m)])
              (let ([new-classroom (copy-classroom current-classroom)])
                (define moves (+ current-moves (length dirty)))
                (let loop ([dirty-list dirty] [current-r start-r] [current-c start-c] [current-moves moves] [visited '()])
                  (cond
                    [(null? dirty-list)
                     (set! best-moves (if (or (not best-moves) (< current-moves best-moves)) current-moves best-moves))]
                    [else
                     (let* ([min-dist #f]
                            [closest-cell #f])
                       (for ([cell dirty-list])
                         (let ([cell-r (car cell)]
                               [cell-c (cdr cell)])
                           (let ([dist (manhattan-distance current-r current-c cell-r cell-c)])
                             (cond
                               [(not min-dist)
                                (set! min-dist dist)
                                (set! closest-cell cell)]
                               [(< dist min-dist)
                                (set! min-dist dist)
                                (set! closest-cell cell)]))))
                       (let ([next-r (car closest-cell)]
                             [next-c (cdr closest-cell)])
                         (vector-set! (vector-ref new-classroom next-r) next-c 0)
                         (loop (filter (lambda (x) (not (equal? x closest-cell))) dirty-list) next-r next-c current-moves-1 (cons (cons next-r next-c) visited))))]))))))
            best-moves))))

  (define (copy-classroom classroom)
    (let ([new-classroom (make-vector n)])
      (for ([i (in-range n)])
        (vector-set! new-classroom i (vector-copy (vector-ref classroom i))))
      new-classroom))

  (solve classroom 0))