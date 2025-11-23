(define (reconstruct-matrix upper lower colsum)
  (let* ([n (length colsum)]
         [row1 (make-vector n 0)]
         [row2 (make-vector n 0)]
         [current-upper upper]
         [current-lower lower)])

    (for ([i (in-range n)])
      (let ([cs (list-ref colsum i)])
        (when (= cs 2)
          (vector-set! row1 i 1)
          (vector-set! row2 i 1)
          (set! current-upper (- current-upper 1))
          (set! current-lower (- current-lower 1)))))

    (when (< current-upper 0) (set! current-upper -1))
    (when (< current-lower 0) (set! current-lower -1))

    (when (and (>= current-upper 0) (>= current-lower 0))
      (for ([i (in-range n)])
        (let ([cs (list-ref colsum i)])
          (when (= cs 1)
            (cond
              [(> current-upper 0)
               (vector-set! row1 i 1)
               (set! current-upper (- current-upper 1))]
              [(> current-lower 0)
               (vector-set! row2 i 1)
               (set! current-lower (- current-lower 1))]
              [else
               (set! current-upper -1) ; Indicate impossibility
               (break)])))))

    (if (and (= current-upper 0) (= current-lower 0))
        (list (vector->list row1) (vector->list row2))
        '())))