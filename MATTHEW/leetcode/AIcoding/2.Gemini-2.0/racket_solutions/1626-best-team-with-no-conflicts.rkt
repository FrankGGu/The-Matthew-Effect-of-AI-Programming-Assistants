(define (best-team-score scores ages)
  (define players (sort (map list ages scores)
                       (lambda (p1 p2)
                         (cond
                           [(< (car p1) (car p2)) #t]
                           [(= (car p1) (car p2)) (< (cadr p1) (cadr p2))]
                           [else #f])))))

  (define n (length scores))
  (define dp (make-vector n 0))

  (for ([i (in-range n)])
    (vector-set! dp i (cadr (list-ref players i)))
    (for ([j (in-range i)])
      (when (<= (cadr (list-ref players j)) (cadr (list-ref players i)))
        (vector-set! dp i (max (vector-ref dp i) (+ (vector-ref dp j) (cadr (list-ref players i))))))))

  (apply max (vector->list dp)))