(define (find-farmland land)
  (define rows (length land))
  (define cols (length (vector-ref land 0)))
  (define result '())

  (define (dfs r c)
    (if (or (< r 0) (>= r rows) (< c 0) (>= c cols) (not (= (vector-ref (vector-ref land r) c) 1)))
        '()
        (begin
          (vector-set! (vector-ref land r) c 0)
          (let ((bottom (dfs (+ r 1) c))
                (right (dfs r (+ c 1))))
            (list (if (null? bottom) r (car bottom))
                  (if (null? bottom) c (cadr bottom)))))))

  (for ((i (in-range rows)))
    (for ((j (in-range cols)))
      (when (= (vector-ref (vector-ref land i) j) 1)
        (let ((boundaries (dfs i j)))
          (when (not (null? boundaries))
            (set! result (cons (list (car boundaries) (cadr boundaries) i j) result)))))))

  (reverse result))

(find-farmland (vector (vector 1 0 0 0 0)
                      (vector 1 0 1 1 0)
                      (vector 0 0 0 1 0)
                      (vector 0 0 0 0 0)
                      (vector 0 1 1 0 0)))