(define (maximizeScore nums multipliers)
  (define n (length nums))
  (define m (length multipliers))
  (define dp (make-vector (+ 1 m) (make-vector (+ 1 m) -1)))

  (define (dfs left right index)
    (if (= index m)
        0
        (let* ((l-score (+ (vector-ref dp left) (vector-ref dp right)))
               (l-max (if (< left n) (+ (list-ref multipliers index) (dfs (+ left 1) right (+ index 1))) -1))
               (r-max (if (< right n) (+ (list-ref multipliers index) (dfs left (+ right 1) (+ index 1))) -1)))
          (max l-max r-max))))

  (dfs 0 0 0))

(maximizeScore (vector 1 2 3) (vector 3 2 1))