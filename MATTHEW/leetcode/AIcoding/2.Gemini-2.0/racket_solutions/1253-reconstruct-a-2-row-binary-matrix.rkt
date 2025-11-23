(define (reconstructMatrix upper lower colsum)
  (let* ([n (length colsum)]
         [row1 (make-vector n 0)]
         [row2 (make-vector n 0)])
    (for/list ([i (in-range n)])
      (cond
        [(= (vector-ref colsum i) 2)
         (if (and (> upper 0) (> lower 0))
             (begin
               (vector-set! row1 i 1)
               (vector-set! row2 i 1)
               (set! upper (- upper 1))
               (set! lower (- lower 1))
              )
             (return #f))]
        [(= (vector-ref colsum i) 1)
         (if (> upper lower)
             (if (> upper 0)
                 (begin
                   (vector-set! row1 i 1)
                   (set! upper (- upper 1))
                  )
                 (return #f))
             (if (> lower 0)
                 (begin
                   (vector-set! row2 i 1)
                   (set! lower (- lower 1))
                  )
                 (return #f)))])
    (cond
      [(and (= upper 0) (= lower 0))
       (list (vector->list row1) (vector->list row2))]
      [else
       #f])))