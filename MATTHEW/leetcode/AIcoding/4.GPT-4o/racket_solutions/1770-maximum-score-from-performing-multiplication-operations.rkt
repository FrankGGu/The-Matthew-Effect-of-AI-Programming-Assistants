(define (maximumScore nums multipliers)
  (define n (length nums))
  (define m (length multipliers))
  (define dp (make-vector (+ 1 m) (make-vector (+ 1 m) -1)))

  (define (solve left right index)
    (if (= index m)
        0
        (let* ((current (vector-ref dp left index)))
          (if (not (= current -1))
              current
              (let* ((left-score (+ (list-ref nums left) (list-ref multipliers index)))
                     (right-score (+ (list-ref nums right) (list-ref multipliers index))))
                (vector-set! dp left index
                             (max (solve (+ left 1) right (+ index 1) left-score)
                                  (solve left (- right 1) (+ index 1) right-score))))))))

  (solve 0 (- n 1) 0))