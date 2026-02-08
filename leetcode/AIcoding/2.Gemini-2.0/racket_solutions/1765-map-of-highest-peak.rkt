(define (highest-peak is-water)
  (let* ([m (length is-water)]
         [n (length (car is-water))]
         [heights (make-matrix m n 0)]
         [queue (list)]
         [visited (make-matrix m n #f)])
    (for ([i (in-range m)]
          [j (in-range n)])
      (when (= (list-ref (list-ref is-water i) j) 1)
        (matrix-set! heights i j 0)
        (matrix-set! visited i j #t)
        (set! queue (append queue (list (list i j))))))

    (letrec ([bfs (lambda (q h)
                      (if (null? q)
                          heights
                          (let* ([curr (car q)]
                                 [i (car curr)]
                                 [j (cadr curr)]
                                 [neighbors (list (list (sub1 i) j)
                                                   (list (add1 i) j)
                                                   (list i (sub1 j))
                                                   (list i (add1 j)))]
                                 [valid-neighbors (filter (lambda (neighbor)
                                                             (and (>= (car neighbor) 0)
                                                                  (< (car neighbor) m)
                                                                  (>= (cadr neighbor) 0)
                                                                  (< (cadr neighbor) n)
                                                                  (not (matrix-ref visited (car neighbor) (cadr neighbor))))
                                                             ) neighbors)])
                            (for ([neighbor (in-list valid-neighbors)])
                              (let* ([ni (car neighbor)]
                                     [nj (cadr neighbor)])
                                (matrix-set! heights ni nj (add1 h))
                                (matrix-set! visited ni nj #t)))
                            (bfs (append (cdr q) valid-neighbors) (add1 h)))))]
      (bfs queue 0))))